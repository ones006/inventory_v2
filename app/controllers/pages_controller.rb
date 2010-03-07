class PagesController < ApplicationController
  before_filter :authenticate, :only => :show
  def index
    redirect_to signin_path unless current_user
    @tab = 'dashboard'
  end

  def show
    @tab = params[:id]
    render @tab
  end

end
