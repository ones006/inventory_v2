Factory.define :user do |u|
  u.sequence(:username) { |n| "foo#{n}" }
  u.sequence(:email)  { |n| "foo#{n}@example.com" }
  u.password "secret"
  u.password_confirmation { |m| m.password }
end

Factory.define :company do |c|
  c.sequence(:name) { |n| "Monster ##{n} Inc."}
  c.sequence(:address) { |n| "Disneyland ##{n} Cikarang" }
  c.sequence(:phone) { |n| "+6221 9424645#{n}" }
end

Factory.define :category do |cat|
  cat.sequence(:name) { |n| "Category Foo ##{n}" }
  cat.description "Placeat qui odit et unde dolores velit dolores sit non rerum non quia aut cumque qui possimus maxime quas eveniet doloribus eius."
end

Factory.define :item do |item|
  item.sequence(:code) { |n| "item#{n}" }
  item.sequence(:name) { |n| "Item Foo #{n}" }
  item.association(:category)
end

Factory.define :warehouse do |warehouse|
  warehouse.sequence(:code) { |n| "WH##{n}" }
  warehouse.sequence(:name) { |n| "Warehouse ##{n}" }
end

Factory.define :supplier do |supplier|
  supplier.association(:company)
  supplier.sequence(:code) { |n| "Supp##{n}" }
  supplier.sequence(:name) { |n| "Supplier ##{n}" }
end
