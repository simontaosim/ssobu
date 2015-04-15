class PersonalCenterController < ApplicationController
  before_action :get_user, only: [:share_order, :my_income, :withdraw]

	 layout 'purestyle'
  def index
  	if session[:progress_id].nil?
        redirect_to mobile_view_login_path, notice: '请先登录'
      else
        #render json: session[:progress_id]["$oid"]
        @session = Session.find(session[:progress_id]["$oid"])
        @user = User.find(@session.user_id)
        @orders_unpaid = Order.where(user_id: @user._id, is_paid: 0 )
        @orders_paid = Order.where(:user_id => @user._id, :is_paid => 1)
      end
  end

  def my_commission
  end

  def apply_cash
  end

  def show_products
    if session[:progress_id].nil?
        redirect_to mobile_view_login_path, notice: '请先登录'
    else
        @session = Session.find(session[:progress_id]["$oid"])
        @user = User.find(@session.user_id)
        @orders_paid = Order.where(:user_id => @user._id, :is_paid => 1)
    end
  end

  def share_order
    @node = Node.where(user_id: @user.id).first
    if params[:product_id]
      @product = Product.find(params[:product_id])
    end
    qr = RQRCode::QRCode.new( personal_center_node_sessions_url+'?user_id='+@user.id.to_s, :size => 8, :level => :h )
    png = qr.to_img                                             # returns an instance of ChunkyPNG
    png.resize(200, 200).save("public/images/node_"+@user.id.to_s+".png")
  end

  def node_sessions
    @node_a = Node.where(user_id: params[:user_id]).first
      session[:from_node] = @node_a.id.to_s
    redirect_to mobile_view_url
  end

  def my_income
    if session[:progress_id].nil?
        redirect_to mobile_view_login_path, notice: '请先登录'
      else
    @node = Node.where(user_id: @user._id).first
    if @node
      @nodes_a = Node.where(a_node: @node.id)
      @nodes_b = Node.where(b_node: @node.id)
      @nodes_c =  Node.where(c_node: @node.id)
    else
      
    end
    
  end
end

  def withdraw
    if session[:progress_id].nil?
        redirect_to mobile_view_login_path, notice: '请先登录'
    else
        @withdraw_record = WithdrawRecord.new
        @withdraw_records = WithdrawRecord.where(user_id: @user.id)
    end
    
  end

  def to_withdraw
    if session[:progress_id].nil?
        redirect_to mobile_view_login_path, notice: '请先登录'
      else
      end
    
  end



  private
  def get_user
    if session[:progress_id].nil?
        redirect_to mobile_view_login_url, notice: '请先登录'
      else
        @session = Session.find(session[:progress_id]["$oid"])
        @user = User.find(@session.user_id)
        @orders_unpaid = Order.where(user_id: @user._id, is_paid: 0 )
        @orders_paid = Order.where(:user_id => @user._id, :is_paid => 1)
      end
    notice = ''
  end

end
