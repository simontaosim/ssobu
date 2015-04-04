class PaymentController < ApplicationController

   skip_before_filter :verify_authenticity_token, only: [:to_pay]
     layout 'purestyle'
  def index
  end

  def to_pay
    order_id = params[:order_id]
      user_id = ''
      user_agent = ''
      amount =''
      product_name= ''
      product_description = ''
      product_log =''
      sign = ''
      redirect_to payment_require_pay_back_path+'?order_id='+order_id+"&user_id="+user_id+"&user_agent="+user_agent+"&amount="+amount+"&product_name="+product_name+"&product_description"+product_description+"&product_log"+product_log 
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
    if params[:order_id]
      redirect_to action: "pay_success", order_id: params[:order_id]
    end
  end
end
