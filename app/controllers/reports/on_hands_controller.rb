class Reports::OnHandsController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab

  def index
    @from = params[:from]
    @until = params[:until]
    @items = current_company.items.all(:order => 'name').paginate(:page => params[:page])
    @items.each { |item| item.sum_on_hand_between(@from, @until) }

    respond_to do |format|
      format.html
    end
  end

  private
  def assign_tab
    @tab = 'reports'
    @current = 'oh'
  end
  
end
