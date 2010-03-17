class LocationsController < ApplicationController
  def new
    @location = current_company.warehouses.find(params[:warehouse_id]).locations.new
  end

  def create
    @location = current_company.warehouses.find(params[:warehouse_id]).locations.new(params[:location])
    if @location.save
      flash[:success] = "Location created"
      redirect_to warehouse_location_path(@location.warehouse, @location)
    else
      render :action => 'new'
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

end
