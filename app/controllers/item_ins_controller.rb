class ItemInsController < ApplicationController
  def index
    @item_ins = ItemIn.all
  end
  
  def new
    @item_in = ItemIn.new
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
end
