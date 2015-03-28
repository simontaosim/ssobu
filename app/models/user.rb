class User
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :role
  field :nickname, type: String
  field :email, type: String
  field :mobile, type: String
  field :third_party, type: String
  field :username, type: String
  field :is_boss, type: Integer
  attr_accessor :password, :password_confirm
  field :encrypt_password, type: String
  validates :username, uniqueness: true
  validates :username, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true

  def md5(pass)
   Digest::MD5.hexdigest(pass)
  end

  def auth(pass)
  	if self.encrypt_password == self.md5(pass)
  		self
  	else
  		nil
  	end
  end

end
