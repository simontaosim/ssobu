class Account
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  field :amount, type: Float
  field :currency, type: String
  field :other, type: String
  field :plus, type: String
  field :message, type: String

<<<<<<< HEAD
  def a_split_cut
    0.20
  end
  def b_split_cut
    0.10
  end
  def c_split_cut
    0.05
=======
  def a_plit_cut
    0.20
  end
  def b_split_cut
    0.12
  end
  def c_split_cut
    0.08
>>>>>>> c6fe1f39e8332af8f745c0def6da8431bbe15e1e
  end
  def origin_split_cut
    0.05
  end

<<<<<<< HEAD
  def split_bill(user,order_id)
    order = Order.find(order_id)
  	amount = order.amount.to_f
  	node = Node.where(order_id: order_id).first
    
  	#分A级别
  	a_node = Node.where(a_node: node._id).first
        if a_node
           a_user = User.find(a_node.user_id)
           a_account = Account.where(user_id: a_user._id).first
           a_amount = a_account.amount + amount*(self.a_split_cut)
           a_account.update_attributes(amount: a_amount)
           a_account.save
        end
  	
  	#分B级别
    b_node = Node.where(b_node: node._id).first
      if b_node
        	b_user = User.find(b_node.user_id)
        	b_account = Account.where(user_id: b_user._id).first
        	b_amount = b_account.amount + amount*(self.b_split_cut)
          b_account.update_attributes(amount: b_amount)
          b_account.save
      end
  	#分C级别
    c_node = Node.where(c_node: node._id).first
    if c_node
        c_user = User.find(c_node.user_id)
        c_account = Account.where(user_id: c_user._id).first
       c_amount = c_account.amount + amount*(self.c_split_cut)
       c_account.update_attributes(amount: c_amount)
       c_account.save
    end


  	#分给原点
  	o_node = Node.where(origin_node: node._id).first
          if o_node
              o_user = User.find(o_node.user_id)
             o_account = Account.where(user_id: o_user._id).first
              o_amount = o_account.amount +amount*(self.origin_split_cut)
              o_account.update_attributes(amount: o_amount)
              o_account.save
          end
        
          node
=======
  def split_bill(user,order )
  	amount = order.amount
  	node = Node.where(order_id: order._id).first

  	#分A级别
  	a_node = Node.where(a_node: node._id).first
  	a_user = User.find(a_node.user_id)
  	a_account = where(user_id: a_user._id).first
  	a_account.amount += amount*(self::a_split_cut)

  	#分B级别
  	b_node = Node.where(b_node: node._id).first
  	b_user = User.find(b_node.user_id)
  	b_account = where(user_id: b_user._id).first
  	b_account.amount += amount*(self::b_split_cut)

  	#分C级别
  	c_node = Node.where(c_node: node._id).first
  	c_user = User.find(c_node.user_id)
  	c_account = where(user_id: c_user._id).first
  	c_account.amount += amount*(self::c_split_cut)

  	#分给原点
  	o_node = Node.where(origin_node: node_id).first
  	o_user = User.find(o_node.user_id)
  	o_account = where(user_id: o_user._id).first
  	o_account.amount += amount*(self::origin_split_cut)


>>>>>>> c6fe1f39e8332af8f745c0def6da8431bbe15e1e
  end

end
