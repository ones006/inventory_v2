class Reports::OnHandsController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab

  def index
    @from = params[:from]
    @until = params[:until]
    @items = current_company.items.all(:order => 'name').paginate(:page => params[:page])
    @items.each { |item| item.sum_on_hand_between(@from, @until) }
    @chart = Gchart.bar(:data => @items.map(&:on_hand_stock),
                        :axis_with_labels => ['y','x'],
                        :axis_labels => [@items.map(&:name).reverse, (0..5).collect {|x| x*10} ],
                        :orientation => 'horizontal',
                        :background => 'f5fff6',
                        :title => 'Stock On Hand',
                        :size => '400x240',
                        :max_value => 50)

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
