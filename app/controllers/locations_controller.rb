class LocationsController < ApplicationController
  def new
    @warehouse = Warehouse.find(params[:warehouse_id])
    @location = @warehouse.locations.new
    render :layout => false if request.xhr?
  end

  def create
    @warehouse = Warehouse.find(params[:warehouse_id])
    @location = @warehouse.locations.new(params[:location])
    @location.company = current_company
    if @location.save
      flash[:success] = "Location created"
      redirect_to warehouse_path(@warehouse)
    else
      if request.xhr?
        form = render_to_string :action => 'new', :layout => false
        status = 'validation error'
        render :json => {'status' => status, 'form' => form }.to_json
      else
        render :action => 'new'
      end
    end
  end

  def edit
    @warehouse = Warehouse.find(params[:warehouse_id])
    @location = Location.find(params[:id])
    render :layout => false if request.xhr?
  end

end
