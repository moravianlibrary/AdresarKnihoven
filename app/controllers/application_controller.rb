class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :set_locale
 
	def set_locale
		if params[:locale]
			if params[:locale] == 'cs' || params[:locale] == 'en'
	  		I18n.locale = params[:locale]
	  	end
	  end
	end
end
