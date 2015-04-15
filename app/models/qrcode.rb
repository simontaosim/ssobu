class Qrcode
  include Mongoid::Document
  field :user_id, type: String
  field :product_id, type: String
  field :url, type: String
end
