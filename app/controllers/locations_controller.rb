class LocationsController < ApplicationController
  before_filter :assign_tab

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
      redirect_to warehouse_path(@location.warehouse)
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

  def update
    @location = Location.find(params[:id])
    respond_to do |format|
      if @location.update_attributes(params[:location])
        flash[:success] = "Location updated"
        format.html { redirect_to @location.warehouse }
      else
        format.html { render :action => :edit }
      end
    end
  end

  def assign_tab
    @tab = 'administrations'
  end

end
