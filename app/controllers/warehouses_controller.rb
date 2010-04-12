class WarehousesController < ApplicationController
  before_filter :authenticate
  before_filter :set_tab

  def index
    @warehouses = current_company.warehouses
  end
  
  def show
    @warehouse = Warehouse.find(params[:id])
  end

  def setdefault
    @warehouse = Warehouse.find(params[:id])
  end

  def setasdefault
    @warehouse = Warehouse.find(params[:id])
    if @warehouse.setasdefault
      flash[:success] = "Operation successful, from now on #{@warehouse.code} is the default warehouse"
      redirect_to warehouses_path
    else
      flash[:error] = "An error occured, please try again"
      redirect_to setdefault_warehouse_path(@warehouse)
    end
  end
  
  def new
    @warehouse = current_company.warehouses.new
    @warehouse.locations.build
    render :layout => false if request.xhr?
  end
  
  def create
    @warehouse = current_company.warehouses.new(params[:warehouse])
    @warehouse.company = current_company
    if @warehouse.save
      flash[:notice] = "Successfully created warehouse."
      xhr_success_response
    else
      xhr_fail_response
    end
  end
  
  def edit
    @warehouse = Warehouse.find(params[:id])
    render :layout => false if request.xhr?
  end
  
  def update
    @warehouse = Warehouse.find(params[:id])
    if @warehouse.update_attributes(params[:warehouse])
      flash[:notice] = "Successfully updated warehouse."
      xhr_success_response
    else
      xhr_fail_response
    end
  end
  
  def destroy
    @warehouse = Warehouse.find(params[:id])
    @warehouse.destroy
    flash[:notice] = "Successfully destroyed warehouse."
    redirect_to warehouses_url
  end

  def plu_available
    @warehouse = Warehouse.find(params[:id])
    item_ids = @warehouse.managed_items.map(&:id)
    @plus = current_company.plus.all(:conditions => { :item_id => item_ids }).to_json(:only => [:id, :code], :methods => :item_name_with_code)
    render :json => { 'plus' => @plus }
  end

  private
  def set_tab
    @tab = "administrations"
  end

  def xhr_success_response
    if request.xhr?
      render :json => { 'location' => warehouses_path}.to_json, :layout => false
    else
      redirect_to @warehouse
    end
  end

  def xhr_fail_response
    if request.xhr?
      form = render_to_string :action => 'new', :layout => false
      status = 'validation error'
      render :json => {'status' => status, 'form' => form }.to_json
    else
      render :action => 'edit'
    end
  end
end
