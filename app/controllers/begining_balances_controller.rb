class BeginingBalancesController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  def index
    @begining_balances = current_company.transactions.all(:conditions => {:tr_type => 'BB'});
  end

  def show
    @begining_balance = BeginingBalance.find(params[:id])
  end
  
  def new
    @begining_balance = current_company.transactions.new
  end
  
  def create
    @begining_balance = current_company.transactions.new(params[:transaction])
    @begining_balance.type = 'BB'
    if @begining_balance.save
      flash[:notice] = "Successfully created begining balance."
      redirect_to begining_balances_url
    else
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
  end
end
