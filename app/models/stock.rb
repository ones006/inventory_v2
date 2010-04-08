class Stock

  def initialize(company)
    @company = company
  end

  def define_time_range(options = nil)
    [ (options && options[:start]) ? Chronic.parse(options[:start]) : @company.first_transaction_date,
      (options && options[:finish]) ? Chronic.parse(options[:finish]) : Time.now ]
  end

  def item_count(trans_ids, item)
    item_id = item.is_a?(Item) ? item.id : item
    Entry.sum(:quantity,
              :joins => 'INNER JOIN transactions on transactions.id = transaction_id',
              :conditions => { :transaction_id => trans_ids, :item_id => item_id })
  end

  def item_in_count(item, start, finish)
    trans_in = Transaction.inward.altering_stock.between(start, finish).map(&:id)
    return 0 if trans_in.blank?
    item_count(trans_in, item)
  end

  def item_out_count(item, start, finish)
    trans_in = Transaction.outward.altering_stock.between(start, finish).map(&:id)
    return 0 if trans_in.blank?
    item_count(trans_in, item)
  end

  def total_item_in_count(item, options = {})
    start, finish = define_time_range(options)

    tmp_item_in = options[:start] ? item_in_count(item, @company.first_transaction_date, start - 1.day) : 0
    cur_item_in = item_in_count(item, start, finish)
    tmp_item_in + cur_item_in
  end

  def total_item_out_count(item, options = {})
    start, finish = define_time_range(options)

    tmp_item_out = options[:start] ? item_out_count(item, @company.first_transaction_date, start - 1.day) : 0
    cur_item_out = item_out_count(item, start, finish)
    tmp_item_out + cur_item_out
  end

  def item_on_hand(item, options = {})
    total_item_in_count(item, options) - total_item_out_count(item, options)
  end

  def item_in_per_warehouse_count(warehouse, item, start, finish)
    trans_in = Transaction.destined_to(warehouse).altering_stock.between(start, finish).map(&:id)
    return 0 if trans_in.blank?
    item_count(trans_in, item)
  end

  def item_out_per_warehouse_count(warehouse, item, start, finish)
    trans_in = Transaction.originated_from(warehouse).altering_stock.between(start, finish).map(&:id)
    return 0 if trans_in.blank?
    item_count(trans_in, item)
  end

  def total_item_in_per_warehouse(warehouse, item, options = {})
    start, finish = define_time_range(options)

    tmp_onhand = options[:start] ? item_in_per_warehouse_count(warehouse, item, @company.first_transaction_date, (start - 1.day)) : 0
    cur_onhand = item_in_per_warehouse_count(warehouse, item, start, finish)
    tmp_onhand + cur_onhand
  end

  def total_item_out_per_warehouse(warehouse, item, options = {})
    start, finish = define_time_range(options)

    tmp_onhand = options[:start] ? item_out_per_warehouse_count(warehouse, item, @company.first_transaction_date, (start - 1.day)) : 0
    cur_onhand = item_out_per_warehouse_count(warehouse, item, start, finish)
    tmp_onhand + cur_onhand
  end

  def item_on_hand_per_warehouse(warehouse, item, options = {})
    total_item_in_per_warehouse(warehouse, item, options) - total_item_out_per_warehouse(warehouse, item, options)
  end

end
