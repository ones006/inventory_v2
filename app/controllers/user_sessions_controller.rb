class UserSessionsController < ApplicationController
  layout 'login'
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Successfully created user session."
      redirect_to root_url
    else
      flash[:error] = "Invalid username or password"
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy unless @user_session.nil?
    flash[:notice] = "You're signed out ."
    redirect_to root_url
  end
end
