class Reports::OnHandsController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab

  def index
    @items = current_company.items.all(:order => 'name')
    @categories = current_company.categories.sorted
  end

  private
  def assign_tab
    @tab = 'reports'
    @current = 'oh'
  end
  
end
