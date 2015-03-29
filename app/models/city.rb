class City
  include Mongoid::Document
  belongs_to :province_state
  field :name, type: String
end
