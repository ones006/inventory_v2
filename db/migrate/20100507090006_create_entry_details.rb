class CreateEntryDetails < ActiveRecord::Migration
  def self.up
    create_table :entry_details do |t|
      t.integer :entry_id
      t.integer :ref_entry_id
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :entry_details
  end
end
