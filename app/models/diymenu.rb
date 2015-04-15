class Diymenu
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :public_account
  field :parent_id, type: String
  field :name, type: String
  field :key, type: String
  field :url, type: String
  field :is_show, type: String
  field :sort, type: String

  CLICK_TYPE = "click"
  VIEW_TYPE = "view"


end
