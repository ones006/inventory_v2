class Tracker
  attr_accessor :item, :transaction

  def initialize(transaction, item)
    @transaction = transaction
    @item = item
  end

  def company
    @transaction.company
  end

  def track(transaction)
    available_stock = @transaction.available_quantity_for(@item)
    requested_quantity = transaction.item_quantity_for(@item)
    if available_stock >= requested_quantity
      FifoTracker.create(:reference_transaction => @transaction,
                         :available_stock => available_stock,
                         :consumer_transaction => transaction,
                         :quantity_consumed => requested_quantity,
                         :company => @transaction.company)
    else
      FifoTracker.create(:reference_transaction => @transaction,
                         :available_stock => available_stock,
                         :consumer_transaction => transaction,
                         :quantity_consumed => available_stock,
                         :company => @transaction.company)
    end
    qty = available_stock - requested_quantity
    qty >= 0 ? 0 : qty
  end

  def track!
    while true
      ref_transaction = @transaction.reference_transaction_for(@item)
      mod_qty = ref_transaction.tracker(@item).track(@transaction)
      break if mod_qty == 0
    end
  end
end
