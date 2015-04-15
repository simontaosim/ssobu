class Admin
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :admin_arole
  field :adminname, type: String
  field :group_id, type: Integer
  attr_accessor :password, :password_confirm
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
