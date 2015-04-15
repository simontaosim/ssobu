class BankCard
  include Mongoid::Document
  belongs_to :account
  field :name, type: String
  field :code, type: String
  field :ower_name, type: String
end
