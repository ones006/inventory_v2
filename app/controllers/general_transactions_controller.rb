class GeneralTransactionsController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab

  def index
    @general_transactions = current_company.general_transactions.all
  end
  
  def show
    @general_transaction = current_company.general_transactions.find(params[:id])
  end
  
  def new
    @general_transaction = current_company.general_transactions.new
    @general_transaction.entries.build
    @plus = current_company.plus.all(:include => :item)
    @hint = 'new_general_transaction'.to_sym
  end
  
  def create
    @general_transaction = current_company.general_transactions.new(params[:general_transaction])
    if @general_transaction.save
      flash[:notice] = "Successfully created general transaction."
      redirect_to @general_transaction
    else
      @hint = 'new_general_transaction'.to_sym
      @plus = current_company.plus.all(:include => :item)
      @number_suggestion = @general_transaction.transaction_type.next_available_number
      render :action => 'new'
    end
  end
  
  def edit
    @general_transaction = current_company.general_transactions.find(params[:id])
  end
  
  def update
    @general_transaction = current_company.general_transactions.find(params[:id])
    if @general_transaction.update_attributes(params[:general_transaction])
      flash[:notice] = "Successfully updated general transaction."
      redirect_to @general_transaction
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @general_transaction = current_company.general_transactions.find(params[:id])
    @general_transaction.destroy
    flash[:notice] = "Successfully destroyed general transaction."
    redirect_to general_transactions_url
  end

  def detail
    @general_transactions = GeneralTransaction.find(params[:id])
  end

  private
  def assign_tab
    @tab = 'transactions'
    @current = 'gt'
  end
end
