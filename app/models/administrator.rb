class Administrator
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :admin_role
  field :adminname, type: String
  attr_accessor :password, :password_confirm, :from_mobile, :reg_for
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
