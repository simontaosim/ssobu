class Catalog
  include Mongoid::Document
  field :name, type: String
  field :fid, type: String
end
