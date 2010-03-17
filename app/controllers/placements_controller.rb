class PlacementsController < ApplicationController
  def index
    @placements = Placement.all
  end
  
  def show
    @placement = Placement.find(params[:id])
  end
  
  def new
    @placement = Placement.new
  end
  
  def create
    @placement = Placement.new(params[:placement])
    if @placement.save
      flash[:notice] = "Successfully created placement."
      redirect_to @placement
    else
      render :action => 'new'
    end
  end
  
  def edit
    @placement = Placement.find(params[:id])
  end
  
  def update
    @placement = Placement.find(params[:id])
    if @placement.update_attributes(params[:placement])
      flash[:notice] = "Successfully updated placement."
      redirect_to @placement
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @placement = Placement.find(params[:id])
    @placement.destroy
    flash[:notice] = "Successfully destroyed placement."
    redirect_to placements_url
  end
end
