class TransactionTypesController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab

  def index
    @transaction_types = TransactionType.all
  end
  
  def show
    @transaction_type = TransactionType.find(params[:id])
  end
  
  def new
    @transaction_type = TransactionType.new
  end
  
  def create
    @transaction_type = TransactionType.new(params[:transaction_type])
    if @transaction_type.save
      flash[:notice] = "Successfully created transaction type."
      redirect_to @transaction_type
    else
      render :action => 'new'
    end
  end
  
  def edit
    @transaction_type = TransactionType.find(params[:id])
  end
  
  def update
    @transaction_type = TransactionType.find(params[:id])
    if @transaction_type.update_attributes(params[:transaction_type])
      flash[:notice] = "Successfully updated transaction type."
      redirect_to @transaction_type
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @transaction_type = TransactionType.find(params[:id])
    @transaction_type.destroy
    flash[:notice] = "Successfully destroyed transaction type."
    redirect_to transaction_types_url
  end

  private
  def assign_tab
    @tab = 'transactions'
  end
end
