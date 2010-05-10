class EntryDetail < ActiveRecord::Base
  belongs_to :entry
  belongs_to :reference_entry_detail, :class_name => 'EntryDetail', :foreign_key => :ref_entry_detail_id

  def reference_entry
    reference_entry_detail.entry
  end

  def assign_used_up(required_quantity)
    remaining_quantity = available_quantity - required_quantity
    update_attributes(:available_quantity => remaining_quantity, :used_up => remaining_quantity == 0)
    remaining_quantity
  end

  def total_value
    quantity * (value || 0)
  end
end
