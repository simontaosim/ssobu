class WithdrawRecord
  include Mongoid::Document
  belongs_to :user
  field :bank_name, type: String
  field :bank_card, type: String
  field :amount, type: Float
  attr_accessor :done
end
