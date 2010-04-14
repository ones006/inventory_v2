class BeginingBalancesController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  def index
    @begining_balances = current_company.begining_balances.all
  end

  def show
    @begining_balance = BeginingBalance.find(params[:id])
  end
  
  def new
    @categories = current_company.leaf_categories
    @begining_balance = current_company.begining_balances.new
    @begining_balance.number = BeginingBalance.suggested_number(current_company)
    #@begining_balance.entries.build(:item_id => 1)
  end
  
  def create
    @begining_balance = current_company.begining_balances.new(params[:begining_balance])
    @begining_balance.destination_warehouse = current_company.default_warehouse
    if @begining_balance.save
      flash[:notice] = "Successfully created begining balance."
      redirect_to begining_balances_url
    else
      @categories = current_company.leaf_categories
      render :action => 'new'
    end
  end
  
  def edit
    @begining_balance = BeginingBalance.find(params[:id])
  end
  
  def update
    @begining_balance = BeginingBalance.find(params[:id])
    if @begining_balance.update_attributes(params[:begining_balance])
      flash[:notice] = "Successfully updated begining balance."
      redirect_to begining_balances_url
    else
      render :action => 'edit'
    end
  end

  private
  def assign_tab
    @tab = 'transactions'
    @current = 'bb'
  end
end
