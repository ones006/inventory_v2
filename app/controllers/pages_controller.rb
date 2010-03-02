class PagesController < ApplicationController
  def index
    redirect_to signin_path unless current_user
    @tab = 'dashboard'
  end

  def show
    @tab = params[:id]
  end

end
