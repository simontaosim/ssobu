class Area
  include Mongoid::Document
  belongs_to :city
  field :name, type: String
end
