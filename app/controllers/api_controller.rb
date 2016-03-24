class ApiController < ApplicationController
	before_action :set_default_response_format

	protected
		def set_default_response_format
		  request.format = :json
		end
end
