class Catalog
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :fid, type: String
end
