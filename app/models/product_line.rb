class ProductLine
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :product
  belongs_to :order
  field :quantity, type: Integer
end
