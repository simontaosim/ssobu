class Order
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  belongs_to :post_address
  field :receiver_name, type: String
  field :receiver_mobile, type: String
  field :receiver_address, type: String
  field :receiver_postcode, type: String
  field :amount, type: Float
  field :is_paid, type: Integer
  field :transtime, type: Integer
  field :delivery_company, type: String
  field :delivery_number, type: String
  field :delivery_time, type: String
end
