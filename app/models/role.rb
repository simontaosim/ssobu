class Role
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :ability, type: Integer
end