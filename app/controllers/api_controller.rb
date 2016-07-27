class ApiController < ApplicationController
	before_action :set_default_response_format
	skip_before_filter :verify_authenticity_token

  	before_filter :cors_preflight_check
 	after_filter :cors_set_access_control_headers




	protected
		def set_default_response_format
		  request.format = :json
		end

	  def cors_set_access_control_headers
	    headers['Access-Control-Allow-Origin'] = '*'
	    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
	    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
	    headers['Access-Control-Max-Age'] = "1728000"
	  end

	  def cors_preflight_check
	    if request.method == 'OPTIONS'
	      headers['Access-Control-Allow-Origin'] = '*'
	      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
	      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
	      headers['Access-Control-Max-Age'] = '1728000'

	      render :text => '', :content_type => 'text/plain'
	    end
	  end
	
end
