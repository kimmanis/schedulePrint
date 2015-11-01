module ClientsHelper
	def getEventOccurrence(id, auth)
		@event = HTTParty.get(Rails.application.secrets.fd_domain+"/api/v2/desk/event_occurrences/#{id}.json?client_id="+Rails.application.secrets.fd_key+"&access_token="+auth) 
		@location_id = @event["event_occurrences"].first["location_id"]	
		@location = HTTParty.get(Rails.application.secrets.fd_domain+"/api/v2/front/locations/#{@location_id}.json?client_id="+Rails.application.secrets.fd_key+"&access_token="+auth) 
		return @event["event_occurrences"].first["staff_members"], @location["locations"].first
	end


end
