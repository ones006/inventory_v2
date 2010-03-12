class PlusController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  before_filter :prepare_autocomplete, :only => [:new, :create, :edit, :update]
  def index
    @plus = current_company.plus
  end
  
  def show
    @plu = Plu.find(params[:id])
  end
  
  def new
    @plu = current_company.plus.new
  end
  
  def create
    @plu = current_company.plus.new(params[:plu])
    if @plu.save
      flash[:notice] = "Successfully created plu."
      redirect_to @plu
    else
      render :action => 'new'
    end
  end
  
  def edit
    @plu = Plu.find(params[:id])
  end
  
  def update
    @plu = Plu.find(params[:id])
    if @plu.update_attributes(params[:plu])
      flash[:notice] = "Successfully updated plu."
      redirect_to @plu
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @plu = Plu.find(params[:id])
    @plu.destroy
    flash[:notice] = "Successfully destroyed plu."
    redirect_to plus_url
  end

  private
  def assign_tab
    @tab = 'administrations'
  end

  def prepare_autocomplete
    @items = current_company.items
    @suppliers = current_company.suppliers
  end
end
