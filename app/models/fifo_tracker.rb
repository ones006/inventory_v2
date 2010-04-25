class FifoTracker < ActiveRecord::Base
  belongs_to :company
  belongs_to :item
  belongs_to :stock_entry, :class_name => 'Entry'
  belongs_to :consumer_entry, :class_name => 'Entry'

  # named_scope :all_transactions, :group => :reference_transaction_id
  named_scope :completed, :conditions => "available_stock = consumed_stock"
  # named_scope :within, lambda { |transaction_ids|
  #   { :conditions => { :reference_transaction_id => transaction_ids } }
  # }

  # def self.available_transaction
  #   all_transactions - completed_transactions
  # end

  # def self.incomplete_within(transaction_ids)
  #   within(transaction_ids) - within(transaction_ids).completed
  # end

  def log_with_self(entry, quantity)
    new_available_quantity = available_stock - consumed_stock
    tracker = company.fifo_trackers.new(:item_id => item_id,
                                        :stock_entry_id => stock_entry_id,
                                        :consumer_entry_id => entry.id)
    if quantity >= new_available_quantity
      tracker.closed            = true
      tracker.available_stock   = new_available_quantity
      tracker.consumed_stock    = new_available_quantity
      FifoTracker.update_all("closed = 1", "stock_entry_id = #{stock_entry_id} AND item_id = #{item_id} AND closed = 0")
    else
      tracker.closed            = false
      tracker.available_stock   = new_available_quantity
      tracker.consumed_stock    = quantity
    end
    tracker.value = stock_entry.value
    tracker.save
    entry_qty_mod = quantity - new_available_quantity
    entry_qty_mod > 0 ? entry_qty_mod : 0
  end

  def log_with_new_reference(entry, quantity, ref_entry)
    tracker = ref_entry.company.fifo_trackers.new(:item_id => ref_entry.item.id,
                                                  :stock_entry_id => ref_entry.id,
                                                  :consumer_entry_id => entry.id)
    if quantity >= ref_entry.quantity
      tracker.closed            = true
      tracker.available_stock   = ref_entry.quantity
      tracker.consumed_stock    = ref_entry.quantity
      FifoTracker.update_all("closed = 1", "stock_entry_id = #{ref_entry.id} AND item_id = #{ref_entry.item.id} AND closed = 0")
    else
      tracker.closed            = false
      tracker.available_stock   = ref_entry.quantity
      tracker.consumed_stock    = quantity
    end
    tracker.value = ref_entry.value
    tracker.save
    ref_entry.quantity >= quantity ? 0 : quantity - ref_entry.quantity
  end

  def log(entry, quantity, ref_entry = nil)
    ref_entry.nil? ? log_with_self(entry, quantity) : log_with_new_reference(entry, quantity, ref_entry)
  end

end
