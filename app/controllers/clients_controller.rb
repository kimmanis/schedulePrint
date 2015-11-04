class ClientsController < ApplicationController
	
	# list clients
	def index
		@token = session["token"]

		if @token
			@email = getEmail(@token)
			@page = params["page"] || 1
			@people, @page_count = getClients(@token, @page)
		else
			redirect_to root_url, :alert => "Please sign in with Front Desk"
		end
	end

	#view client's schedule
	def show
		@client = params[:id]
		@token = session["token"]

		if @token
			@visits = getVisits(@client, @token)
		else
			redirect_to root_url, :alert => "Please sign in with Front Desk"
		end
	end

	# get info from FD API

	def getVisits(id, auth)
	  @result = HTTParty.get(session["domain"]+"/api/v2/desk/people/"+id+"/visits.json?per_page=100&client_id="+Rails.application.secrets.fd_key+"&access_token="+auth) 
	  return  @result["visits"]
	end

	def getEmail(auth)
	  	@result = HTTParty.get(session["domain"]+"/api/v2/front/people/me.json?client_id="+Rails.application.secrets.fd_key+"&access_token="+auth) 
	  	return @result["people"].first["email"]
	end

	def getClients(auth, page)
		per_page = 50
		@result = HTTParty.get(session["domain"]+
			"/api/v2/desk/people.json?page=" + page.to_s + 
			"&per_page=" + per_page.to_s + 
			"&client_id=" + Rails.application.secrets.fd_key +
			"&access_token=" +auth
			) 
		 
	  	return @result["people"], (@result["total_count"].to_f / per_page).to_f.ceil

	end

	
	


end
