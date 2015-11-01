class HomeController < ApplicationController

	def index
		@callback = Rails.application.secrets.fd_domain+'/oauth/authorize?client_id='+Rails.application.secrets.fd_key+
		'&response_type=code&redirect_uri='+Rails.application.secrets.domain_name+'/auth'
	end
end


