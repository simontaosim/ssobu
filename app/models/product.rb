class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  belongs_to :post_address
  field :name, type: String
  field :price, type: Float
  field :boss_price, type: Float
  field :origin_price, type: Float
  field :contract_person, type: String
  field :express_price, type: String
  field :address, type: String
end
