class Account
  include Mongoid::Document
  field :total, type: String
  field :currency, type: String
  field :other, type: String
  field :plus, type: String
  field :massage, type: String
end
