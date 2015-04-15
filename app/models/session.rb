class Session
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  field :username, type: String
end
