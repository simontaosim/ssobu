class PaymentController < ApplicationController

<<<<<<< HEAD
   skip_before_filter :verify_authenticity_token, only: [:to_pay, :pay_success]
=======
   skip_before_filter :verify_authenticity_token, only: [:to_pay]
>>>>>>> c6fe1f39e8332af8f745c0def6da8431bbe15e1e
     layout 'purestyle'
  def index
  end

  def to_pay
    order_id = params[:order_id]
    order = Order.find(order_id)
  
    identity_id = order.user_id.to_s
     user_ip = request.remote_ip
     user_ua = request.user_agent
<<<<<<< HEAD
     if order.transtime.nil?
       transtime = Time.now.to_i
       order.update_attributes(transtime: transtime)
     end
     transtime = order.transtime
=======
     transtime = Time.now.to_i
>>>>>>> c6fe1f39e8332af8f745c0def6da8431bbe15e1e
      if  session[:progress_id]
       @product_line = ProductLine.where(cart_id: session[:cart_id]).first
        @product = Product.find(@product_line.product_id)
    end
      product_name="uboss-"+@product.name
      quantity = @product_line.quantity.to_i
      current_price = @product_line.current_price.to_f
      amount = ((quantity*current_price)*100).to_i
      product_catalog = @product.catalog_id
      product_desc = @product.description
      sign = order_id
      sign += 7.to_s
      sign += identity_id
      sign += user_ip.to_s
      sign += user_ua
      sign += transtime.to_s+product_name+product_desc+amount.to_s
      sign =  Digest::MD5.hexdigest(sign)
      url = URI.parse('http://183.57.43.251/toMobilepay.php')
      response = Net::HTTP.post_form(url,{'order_id' => order_id, 'transtime' => transtime.to_s, 'identity_id' => identity_id, 'user_ip' => user_ip.to_s, 'user_ua' => user_ua, 'amount' => amount.to_s,  'product_name' => product_name, 'product_desc' => product_desc, 'product_catalog' => '7', 'sign' => sign})
      to_jump = response.body
      #render plain: to_jump
     to_jump[0,9] = ''
     redirect_to 'https://'+to_jump.to_s
     # redirect_to "http://183.57.43.251/toMobilepay.php"+'?order_id='+order_id+"&transtime="+transtime.to_s+"&identity_id="+identity_id+"&user_ip="+user_ip.to_s+"&user_ua="+user_ua+"&amount="+amount.to_s+"&product_name="+product_name+"&product_desc="+product_desc+"&product_catalog="+product_catalog+"&sign="+sign
  end

  def pay_success
<<<<<<< HEAD
      @session = Session.find(session[:progress_id]["$oid"].to_s)
      #render json: @session
      @order = Order.find(params[:order_id])
      @order.update_attributes(:is_paid => 1)
      @user = User.find(@session.user_id)
      @user.update_attributes(:is_boss => 1)

      amount = @order.amount
      node = Node.where(user_id: @user.id).first
     #==========给A分钱=================================
      if node.a_node
        a_node = Node.find(node.a_node)
        a_user = User.find(a_node.user_id)
        a_account = Account.where(user_id: a_user.id).first
        if a_account
        else
          a_account = create_new_acccount(a_user.id)
        end
        comission = amount.to_f * a_account.a_split_cut.to_f
        total_amount = comission + a_account.amount.to_f
        a_account.update_attributes(amount: total_amount.to_f)
      end


     #============================================
      #==========给B分钱=================================
       if node.b_node
        b_node = Node.find(node.b_node)
        b_user = User.find(b_node.user_id)
        b_account = Account.where(user_id: b_user.id).first
        if b_account
        else
          b_account = create_new_acccount(b_user.id)
        end
        comission = amount.to_f * b_account.b_split_cut.to_f
        total_amount = comission + b_account.amount.to_f
        b_account.update_attributes(amount: total_amount.to_f)
      end
      

     #============================================
      #==========给C分钱=================================
       if node.c_node
        c_node = Node.find(node.c_node)
        c_user = User.find(c_node.user_id)
        c_account = Account.where(user_id: c_user.id).first
        if c_account
        else
          c_account = create_new_acccount(c_user.id)
        end
        comission = amount.to_f * c_account.c_split_cut.to_f
        total_amount = comission + c_account.amount.to_f
        c_account.update_attributes(amount: total_amount.to_f)
      end
      

     #============================================
      #==========给原点分钱=================================
       if node.origin_node
        o_node = Node.find(node.origin_node)
        o_user = User.find(o_node.user_id)
        o_account = Account.where(user_id: o_user.id).first
        if o_account
        else
          o_account = create_new_acccount(o_user.id)
        end
        comission = amount.to_f * o_account.origin_split_cut.to_f
        total_amount = comission + o_account.amount.to_f
        o_account.update_attributes(amount: total_amount.to_f)
      end
      

     #============================================
      
=======
    @session = Session.find(session[:progress_id])
      @order = Order.find(params[:order_id])
      @user = User.find(@session.user_id)
      node = Node.new
      node.order_id = @order._id
      node.user_id  = @user._id
      node.is_origin = 0
      if params[:node_id]
      else
        node.level = 0
      origin_node = node. generate_origin_node
      origin_user = User.find(origin_node.user_id)
      account = Account.new
      account.user_id = origin_user._id
      amount = @order.amount.to_f
      split_cut = account.origin_split_cut
      account.amount = 0
      origin_amount = account.amount.to_f
      origin_amount = amount*split_cut
      account.amount = origin_amount
      account.save
      node.save
      @notice = '支付成功'
      end
      
>>>>>>> c6fe1f39e8332af8f745c0def6da8431bbe15e1e
   end

  def pay_fail
     @notice = '支付失败'
  end

  def require_pay_back
    if params[:status] == '1'
      redirect_to action: 'pay_success' , order_id: params[:order_id]
    else
      redirect_to action: 'pay_fail', order_id: params[:order_id]
    end
  end
<<<<<<< HEAD
  private

  def create_new_acccount(user_id)
    account = Account.new
    account.user_id = user_id
    account.amount = 0
    account.save
    account
  end

=======
>>>>>>> c6fe1f39e8332af8f745c0def6da8431bbe15e1e
end
