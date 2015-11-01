class AuthController < ApplicationController
	def index
		@result = HTTParty.post("https://frontdeskhq.com/oauth/token", 
		    :body => { :grant_type=> "authorization_code",
		               :code => params['code'], 
		               :redirect_uri => Rails.application.secrets.domain_name+'/auth', 
		               :client_id => Rails.application.secrets.fd_key, 
		               :client_secret => Rails.application.secrets.fd_secret,
		             }.to_json,
		    :headers => { 'Content-Type' => 'application/json' } )

		@token = @result["access_token"]

		@email = getEmail(@token)

		@people = getClients(@token)
	end

	def getEmail(auth)
	  	@result = HTTParty.get(Rails.application.secrets.fd_domain+"/api/v2/front/people/me.json?client_id="+Rails.application.secrets.fd_key+"&access_token="+auth) 
	  	return @result["people"].first["email"]
	end

	def getClients(auth)
		@result = HTTParty.get(Rails.application.secrets.fd_domain+"/api/v2/desk/people.json?client_id="+Rails.application.secrets.fd_key+"&access_token="+auth) 
	  	return @result["people"]
	end
	
end
