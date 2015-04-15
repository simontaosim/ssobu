class PublicAccount
  include Mongoid::Document
  include Mongoid::Timestamps
  include WeixinRailsMiddleware::AutoGenerateWeixinTokenSecretKey
  field :weixin_secret_key, type: String
  field :weixin_token, type: String
  field :encoding_aes_key, type:String
  field :app_id, type:String
end
