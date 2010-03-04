# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  helper_method :current_user_session, :current_user, :current_company, :authenticate
  # rescue_from CanCan::AccessDenied do |exception|
  #   flash[:error] = "Maaf, anda tidak bisa mengakses halaman tersebut."
  #   redirect_to root_path
  # end

  private
  def current_company
    return @current_company if defined?(@current_company)
    @current_company = Company.find_by_subdomain(current_subdomain)
  end

  def authenticate
    unless current_user
      flash[:error] = "Sorry, you have to log in first."
      redirect_to root_url and return
    end
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  protected
  def clear_authlogic_session
    sess = current_user_session
    sess.destroy if sess
    reset_session
    redirect_to login_path and return
  end

  def session_timeout
    flash[:error] = "Sorry, but your session has just timed out. Please re-login to continue."
    clear_authlogic_session
  end
end

