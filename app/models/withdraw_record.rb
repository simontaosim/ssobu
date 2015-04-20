class WithdrawRecord
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  field :bank_name, type: String
  field :bank_card, type: String
  field :amount, type: Float
  field :done, type: Integer
end
