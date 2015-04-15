class AdminSession
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :admin
  field :adminname, type: String
end
