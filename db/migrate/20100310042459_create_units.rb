class CreateUnits < ActiveRecord::Migration
  def self.up
    create_table :units do |t|
      t.integer :item_id
      t.integer :position
      t.string :name
      t.integer :conversion_rate

      t.timestamps
    end
  end

  def self.down
    drop_table :units
  end
end
