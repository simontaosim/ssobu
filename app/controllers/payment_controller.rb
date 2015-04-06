class PaymentController < ApplicationController

   skip_before_filter :verify_authenticity_token, only: [:to_pay]
     layout 'purestyle'
  def index
  end

  def to_pay
    order_id = params[:order_id]
    order = Order.find(order_id)
  
    identity_id = order.user_id.to_s
     user_ip = request.remote_ip
     user_ua = request.user_agent
     transtime = Time.now.to_i
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
end
