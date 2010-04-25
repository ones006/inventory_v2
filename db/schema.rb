# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100425072451) do

  create_table "categories", :force => true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.text     "description"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subdomain"
  end

  create_table "entries", :force => true do |t|
    t.integer  "company_id"
    t.integer  "transaction_id"
    t.integer  "plu_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_id"
    t.integer  "value"
  end

  create_table "items", :force => true do |t|
    t.integer  "category_id"
    t.string   "code"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "count_method", :default => "avg"
  end

  create_table "locations", :force => true do |t|
    t.integer  "warehouse_id"
    t.string   "code"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.integer  "position"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
  end

  create_table "placements", :force => true do |t|
    t.integer  "company_id"
    t.integer  "warehouse_id"
    t.integer  "plu_id"
    t.integer  "quantity"
    t.string   "reference"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plus", :force => true do |t|
    t.integer  "item_id"
    t.integer  "supplier_id"
    t.string   "payment_term"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "code"
  end

  create_table "suppliers", :force => true do |t|
    t.integer  "company_id"
    t.string   "code"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trackers", :force => true do |t|
    t.integer  "stock_entry_id"
    t.integer  "consumer_entry_id"
    t.integer  "available_stock"
    t.integer  "consumed_stock"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.integer  "item_id"
    t.boolean  "closed",            :default => false
    t.integer  "value"
    t.string   "type"
  end

  create_table "transaction_types", :force => true do |t|
    t.integer  "company_id"
    t.string   "code"
    t.text     "description"
    t.integer  "direction",   :default => 0
    t.boolean  "negate",      :default => false
    t.boolean  "alter_date",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "alter_stock"
    t.string   "name"
  end

  create_table "transactions", :force => true do |t|
    t.string   "number"
    t.integer  "origin_id"
    t.integer  "destination_id"
    t.integer  "quantity"
    t.string   "transaction_ref"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "type"
    t.text     "remark"
    t.boolean  "alter_stock",         :default => true
    t.integer  "transaction_type_id"
  end

  create_table "units", :force => true do |t|
    t.integer  "item_id"
    t.integer  "position"
    t.string   "name"
    t.integer  "conversion_rate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  create_table "warehouses", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.boolean  "default"
  end

end
