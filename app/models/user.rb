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
<<<<<<< HEAD
  attr_accessor :password, :password_confirm, :from_mobile, :reg_for, :login_by, :verifycode
=======
  attr_accessor :password, :password_confirm, :from_mobile, :reg_for
>>>>>>> c6fe1f39e8332af8f745c0def6da8431bbe15e1e
  field :encrypt_password, type: String
 
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
