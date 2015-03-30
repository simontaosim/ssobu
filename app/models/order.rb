class Order
  include Mongoid::Document
  belongs_to :user
  belongs_to :post_address
  field :massage, type: String
  field :total_price, type: Float
end
