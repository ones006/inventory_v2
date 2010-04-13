class ItemOutsController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab

  def index
    @item_outs = current_company.item_outs.all
  end
  
  def new
    @item_out = current_company.item_outs.new
    @item_out.number = ItemOut.suggested_number(current_company)
    @item_out.origin_id = current_company.default_warehouse.id
    @item_out.entries.build
    @plus = current_company.plus.all(:include => :item)
  end
  
  def create
    @item_out = current_company.item_outs.new(params[:item_out])
    @item_out.entries.each do |entry| 
      entry.warehouse_id = @item_out.origin_id
      entry.validating_quantity = true
    end
    if @item_out.save
      flash[:notice] = "Successfully created item out."
      redirect_to @item_out
    else
      @plus = current_company.plus.all(:include => :item)
      render :action => 'new'
    end
  end
  
  def show
    @item_out = ItemOut.find(params[:id])
  end

  def destroy
    @item_out = ItemOut.find(params[:id])
    @item_out.destroy
    flash[:notice] = "Transaction #{@item_out.number} successfuly destroyed"
    redirect_to item_outs_path
  end

  private
  def assign_tab
    @tab = 'transactions'
  end
end
