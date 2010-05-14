class Reports::OnHandsController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab

  def index
    all_items = Item.search(:company_id => current_company)
    @category = params[:category]
    all_items = all_items.category_id_is(@category) unless @category.nil?
    @until = params[:until] unless params[:until].blank?
    @items = all_items.all(:order => 'name ASC').paginate(:page => params[:page])

    @items.each { |item| item.sum_on_hand_between(nil, @until) }
    @categories = current_company.categories.sorted

    respond_to do |format|
      format.html
      format.pdf
    end
  end

  private
  def assign_tab
    @tab = 'reports'
    @current = 'oh'
  end
  
end
