class ItemInsController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab

  def index
    @item_ins = ItemIn.all
  end
  
  def new
    @item_in = ItemIn.new
    @item_in.number = ItemIn.suggested_number(current_company)
    @item_in.destination_id = current_company.default_warehouse.id
    @item_in.entries.build
    @plus = current_company.plus.all(:include => :item)
  end
  
  def create
    @item_in = ItemIn.new(params[:item_in])
    if @item_in.save
      flash[:notice] = "Successfully created item in."
      redirect_to @item_in
    else
      render :action => 'new'
    end
  end
  
  def show
    @item_in = ItemIn.find(params[:id])
  end

  private
  def assign_tab
    @tab = 'transactions'
  end
end
