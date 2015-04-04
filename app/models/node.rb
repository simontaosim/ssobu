class Node
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  belongs_to :order
  field :is_origin, type: Integer
  field :name, type: String
  field :origin_node, type: String
  field :a_node, type: String #表示这个node是谁的A
  field :b_node, type: String #表示这个node是谁的B
  field :c_node, type: String #表示这个node是谁的C
  field :level, type: Integer

  def add_node(user,node,order)
  	node.user_id = user._id
  	node.order_id = order._id
  	node.level = self.level + 1
  	if node
  		node.a_node = self._id
  	end
  	if self.a_node
  		node.b_node = self.a_node		
  	end
  	if self.b_node
  		node.c_node = self.b_node
  	end 

  	if self.origin_node
  		node.origin_node = self.origin_node
  	end
  	if node.save
  		node
  	end
  	node
  end

  def generate_origin_node
  	if self.order_id
  		origin_node = Node.new
  		t = Time.now
  		t = t.to_i
  		if User.where(username: t.to_s)
  			t = t+100
  		end
  		t = t.to_s
  		user = User.new
  		user.username = t
  		user.encrypt_password = user.md5('12345678')
  		if user.save
  			origin_node.user_id = user._id
                      origin_node.is_origin = 1 
  			origin_node.level = 0
  			if origin_node.save
  				self.origin_node = origin_node._id
  				return origin_node
  			end
  		end
  		
  	end
  end
end
