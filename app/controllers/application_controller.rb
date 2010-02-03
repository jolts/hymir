# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :set_locale

  include Hymir # lib/hymir.rb
  include Authentication # lib/authentication.rb

  helper :all
  protect_from_forgery
  filter_parameter_logging :password, :password_confirmation

  protected
    def set_locale
      unless params[:locale].blank? || !I18n.available_locales.include?(params[:locale].to_sym)
        I18n.locale = params[:locale]
      end
    end
  #

  private
    def login_required
      unless signed_in?
        store_location
        flash[:error] = t('flash.error.access_denied')
        redirect_to login_path
        return false
      end
    end

    def store_location
      disallowed_urls = [login_url, logout_url]
      disallowed_urls.map! {|url| url[/\/\w+$/]}
      unless disallowed_urls.include?(request.request_uri)
        session[:return_to] = request.request_uri
      end
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
  # private
end
