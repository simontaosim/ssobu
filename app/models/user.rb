class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :email, type: String
  field :mobile, type: String
  field :third_party, type: String
  field :username, type: String
  attr_accessor :password, :password_confirm
  field :encrypt_password, type: String

  validates :username, uniqueness: true

  def md5(pass)
   Digest::MD5.hexdigest(pass)
  end

  def auth(user,pass)
  	if user.encrypt_password == User.find(user._id).md5(pass)
  		user
  	else
  		'密码错误'
  	end
  end

end
