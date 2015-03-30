class PostAddress
  include Mongoid::Document
  belongs_to :planet
  belongs_to :country
  belongs_to :province
  belongs_to :city
  belongs_to :area
  field :end_detail, type: String
  field :whole_details, type: String
end
