# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :set_locale

  include Hymir # lib/hymir.rb
  include Authentication # lib/authentication.rb

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = 'Access denied.'
    redirect_to root_url
  end

  private
    def set_locale
      I18n.locale = params[:locale] unless params[:locale].blank? || !I18n.available_locales.include?(params[:locale].to_sym)
    end
  # private
end
