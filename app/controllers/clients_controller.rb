class ClientsController < ApplicationController
	def show
		@client = params[:id]
		@token = params[:token]

		if @token
			@visits = getVisits(@client, @token)
		else
			redirect_to root_url, :alert => "Please sign in with Front Desk"
		end
	end


	def getVisits(id, auth)
	  @result = HTTParty.get(Rails.application.secrets.fd_domain+"/api/v2/desk/people/"+id+"/visits.json?client_id="+Rails.application.secrets.fd_key+"&access_token="+auth) 
	  return  @result["visits"]
	end

	


end
