class Node
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  field :name, type: String
  field :fnode, type: String
  field :level, type: Integer
end
