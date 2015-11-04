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

		Rails.application.secrets.token = @result["access_token"]

		redirect_to "/clients"
	end

	
	
end
