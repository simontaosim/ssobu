class Order
  include Mongoid::Document
  embedded_in :user
end
