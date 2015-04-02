class ProductLine
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :product
  belongs_to :order
  belongs_to :cart
  field :quantity, type: Integer
  field :order_id, type: String
end
