class HomeController < ApplicationController

	def index
		@domain = params["domain"]
		if @domain
			session["domain"] = "https://"+@domain+".frontdeskhq.com"
			@callback = session["domain"]+'/oauth/authorize?client_id='+Rails.application.secrets.fd_key+
		'&response_type=code&redirect_uri='+Rails.application.secrets.domain_name+'/auth'
			redirect_to @callback
		end
	end
end


