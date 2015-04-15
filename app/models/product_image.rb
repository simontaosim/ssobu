class ProductImage
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :product
  field :name, type: String
  field :is_cover, type: Integer
  field :url, type: String
end
