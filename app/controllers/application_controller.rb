class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Authenticate an API key from clients
  def authenticate_api_key
  	# Verify that there's a registered UUID
  	parsed_body = JSON.parse(request.body.string)
  	uuid = params['client_uuid']
  	uuid = parsed_body['client_uuid']
  	return json_error 'Missing Client UUID', 1000 if uuid.nil?

  	# Verify that there's an API key
  	api_key = params['api_key']
  	api_key = parsed_body['api_key']
		return json_error 'Missing API Key', 1002 if api_key.nil?

		client_array = Client.where(uuid: uuid)
		return json_error 'UUID Not Registered', 1001 if client_array.empty?
		@client = client_array.first
		return json_error 'Invalid API Key', 1003 unless @client.api_key == api_key

		return true
	end

	# 1000 - 1999: authentication errors
	# 2000 - 2999: invalid requests
	# 3000 - 3001: internal server errors
	def json_error error, number
		logger.debug "Error #{number}: #{error}"
		render json: {error: {"#{number}": error}}
		return false
	end

end
