class ProvinceState
  include Mongoid::Document
  belongs_to :country
  field :name, type: String
end
