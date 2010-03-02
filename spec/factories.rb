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
