class ItemInsController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab

  def index
    @item_ins = current_company.item_ins.all
  end
  
  def new
    @item_in = current_company.item_ins.new
    @item_in.number = ItemIn.suggested_number(current_company)
    @item_in.destination_id = current_company.default_warehouse.id
    @item_in.entries.build
    @plus = current_company.plus.all(:include => :item)
  end
  
  def create
    @item_in = current_company.item_ins.new(params[:item_in])
    if @item_in.save
      flash[:notice] = "Successfully created item in."
      redirect_to @item_in
    else
      @plus = current_company.plus.all(:include => :item)
      render :action => 'new'
    end
  end
  
  def show
    @item_in = current_company.item_ins.find(params[:id])
  end

  private
  def assign_tab
    @tab = 'transactions'
  end
end
