class TransactionTypesController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab

  def index
    @transaction_types = current_company.transaction_types.all
  end
  
  def show
    @transaction_type = current_company.transaction_types.find(params[:id])
  end
  
  def new
    @transaction_type = current_company.transaction_types.new
    @hint = 'new_transaction_type'.to_sym
  end
  
  def create
    @transaction_type = current_company.transaction_types.new(params[:transaction_type])
    if @transaction_type.save
      flash[:notice] = "Successfully created transaction type."
      redirect_to @transaction_type
    else
      render :action => 'new'
    end
  end
  
  def edit
    @transaction_type = current_company.transaction_types.find(params[:id])
  end
  
  def update
    @transaction_type = current_company.transaction_types.find(params[:id])
    if @transaction_type.update_attributes(params[:transaction_type])
      flash[:notice] = "Successfully updated transaction type."
      redirect_to @transaction_type
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @transaction_type = current_company.transaction_types.find(params[:id])
    @transaction_type.destroy
    flash[:notice] = "Successfully destroyed transaction type."
    redirect_to transaction_types_url
  end

  private
  def assign_tab
    @tab = 'transactions'
    @current = 'tt'
  end
end
