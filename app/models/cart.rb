class Cart
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :order
end
