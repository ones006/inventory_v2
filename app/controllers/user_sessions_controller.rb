class UserSessionsController < ApplicationController
  layout 'login'
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      company = Company.find_by_subdomain(current_subdomain)
      unless company.users.include? current_user
        @user_session.destroy
        redirect_to signin_path
      else
        flash[:notice] = "Successfully created user session."
        redirect_to root_url
      end
    else
      flash[:error] = "Invalid username or password"
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy unless @user_session.nil?
    flash[:notice] = "You're signed out ."
    redirect_to signin_url
  end

end
