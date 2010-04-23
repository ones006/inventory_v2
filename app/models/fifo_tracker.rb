class FifoTracker < ActiveRecord::Base
  belongs_to :company
  belongs_to :item
  belongs_to :reference_transaction, :class_name => 'Transaction'
  belongs_to :consumer_transaction, :class_name => 'Transaction'
  validates_presence_of :company_id

  named_scope :all_transactions, :group => :reference_transaction_id
  named_scope :completed, :conditions => "available_stock = quantity_consumed"
  named_scope :within, lambda { |transaction_ids|
    { :conditions => { :reference_transaction_id => transaction_ids } }
  }

  def self.available_transaction
    all_transactions - completed_transactions
  end

  def self.incomplete_within(transaction_ids)
    within(transaction_ids) - within(transaction_ids).completed
  end

  def log_with_self(entry, quantity)
    new_available_quantity = available_stock - quantity_consumed
    tracker = company.fifo_trackers.new(:item_id => item_id,
                                        :reference_transaction_id => reference_transaction_id,
                                        :consumer_transaction_id => entry.transaction_id)
    if quantity >= new_available_quantity
      tracker.closed            = true
      tracker.available_stock   = new_available_quantity
      tracker.quantity_consumed = new_available_quantity
      FifoTracker.update_all("closed = 1", "reference_transaction_id = #{reference_transaction_id} AND item_id = #{item_id} AND closed = 0")
    else
      tracker.closed            = false
      tracker.available_stock   = new_available_quantity
      tracker.quantity_consumed = quantity
    end
    tracker.value = reference_transaction.entries.first(:conditions => { :item_id => item_id }).value
    tracker.save
    entry_qty_mod = quantity - new_available_quantity
    entry_qty_mod > 0 ? entry_qty_mod : 0
  end

  def log_with_new_reference(entry, quantity, ref_entry)
    tracker = ref_entry.company.fifo_trackers.new(:item_id => ref_entry.item.id,
                                                  :reference_transaction_id => ref_entry.transaction.id,
                                                  :consumer_transaction_id => entry.transaction.id)
    if quantity >= ref_entry.quantity
      tracker.closed            = true
      tracker.available_stock   = ref_entry.quantity
      tracker.quantity_consumed = ref_entry.quantity
      FifoTracker.update_all("closed = 1", "reference_transaction_id = #{ref_entry.transaction.id} AND item_id = #{ref_entry.item.id} AND closed = 0")
    else
      tracker.closed            = false
      tracker.available_stock   = ref_entry.quantity
      tracker.quantity_consumed = quantity
    end
    tracker.value = ref_entry.value
    tracker.save
    ref_entry.quantity >= quantity ? 0 : quantity - ref_entry.quantity
  end

  def log(entry, quantity, ref_entry = nil)
    ref_entry.nil? ? log_with_self(entry, quantity) : log_with_new_reference(entry, quantity, ref_entry)
  end

end
