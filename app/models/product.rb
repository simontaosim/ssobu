class Product
  include Mongoid::Document
  belongs_to :order
  field :name, type: String
  field :price, type: Float
  field :origin_price, type: Float
end
