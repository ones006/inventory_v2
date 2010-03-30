class ItemsController < ApplicationController
  before_filter :set_tab
  before_filter :authenticate
  before_filter :categories_list, :except => [:index, :show]
  def index
    if params[:category_id]
      @items = current_company.categories.find(params[:category_id]).items
    else
      @items = current_company.items
    end
  end
  
  def show
    @item = Item.find(params[:id])
    render :layout => false if request.xhr?
  end
  
  def new
    @item = Item.new
    @item.units.build(:name => 'unit', :conversion_rate => 1)
    render :layout => false if request.xhr?
  end
  
  def create
    @item = Item.new(params[:item])
    @item.company = current_company
    if @item.save
      flash[:notice] = "Successfully created item."
      if request.xhr?
        render :json => { 'location' => items_path}.to_json, :layout => false
      else
        redirect_to items_path
      end
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
    @item = Item.find(params[:id])
    @item.units.build(:name => 'unit', :conversion_rate => 1) if @item.units.length < 1
    render :layout => false if request.xhr?
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item])
      flash[:notice] = "Successfully updated item."
      if request.xhr?
        render :json => { 'location' => items_path}.to_json, :layout => false
      else
        redirect_to @item
      end
    else
      if request.xhr?
        form = render_to_string :action => 'edit', :layout => false
        status = 'validation error'
        render :json => {'status' => status, 'form' => form }.to_json
      else
        render :action => 'edit'
      end
    end
  end
  
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:notice] = "Successfully destroyed item."
    redirect_to items_url
  end

  private
  def set_tab
    @tab = 'administrations'
  end

  def categories_list
    @categories_list = leaf_category_names
  end
end
