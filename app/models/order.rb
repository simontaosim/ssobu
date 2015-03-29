class Order
  include Mongoid::Document
  belongs :user
  belongs :post_address
end
