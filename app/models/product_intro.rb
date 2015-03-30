class ProductIntro
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :product
  field :promotion, type: String
  field :description, type: String
end
