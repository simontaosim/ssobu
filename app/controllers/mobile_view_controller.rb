#encoding: utf-8
class MobileViewController < ApplicationController
  layout 'purestyle'

  before_action :check_user_session, except: [:login, :regist, :index, :about_boss, :send_verifycode, :check_verifycode,:yeepay_school,:about, :protocol, :auth_login]
 # before_action :get_user_agent#, only: [:index]
  skip_before_filter :verify_authenticity_token, only: [:buy_where, :go_order, :order_confirm, :to_pay, :send_verifycode, :check_verifycode, :auth_login ]
  

  def index
      if params[:notice]
        notice = params[:notice]
      end
  end

  def login
    session[:last_verifycode_time] = nil
    @user = User.new
    if params[:d]
      session[:from_index] = '1'
      session[:ulaiber] = '1'
    end
    if session[:progress_id] and session[:from_index]
      respond_to do |format|
        format.html { redirect_to mobile_view_login_path, notice: '请先登录'    }
      end
    end
  end

  def show_product
    if params[:product_id]
      @product = Product.find(params[:product_id])
    end
    if session[:from_index]
      @product = Product.where(name: /#{'奔跑吧！兔子'}/).first
    end

    if session[:username]
       @product = Product.where(name: /#{'奔跑吧！兔子'}/).first
    else
      respond_to do |format|
        format.html { redirect_to mobile_view_login_path }
      end
    end
  end

  def buy_where
    if params[:quantity] and params[:product_id]
      @product_line = ProductLine.new
      @cart = Cart.new
      @cart.save
      @product_line.quantity = params[:quantity]
      @product_line.current_price = Product.find(params[:product_id]).price
      @product_line.product_id = params[:product_id]
      @product_line.cart_id = @cart._id
      session[:cart_id] = @cart._id.to_s

        if @product_line.save
          #render json: @product_line
          respond_to do |format|
            format.html { redirect_to mobile_view_address_confirm_path  }
          end  
        else
          respond_to do |format|
            format.html { redirect_to mobile_view_login_path, notice: '请先登录'}
          end  
        end
    end
  end

  def go_order
      if params[:receiver_name] and params[:receiver_name] and params[:receiver_address] and params[:receiver_postcode]
         @order  = Order.new
         @order.receiver_name = params[:receiver_name]
         @order.receiver_mobile =  params[:receiver_mobile]
         @order.receiver_address = params[:receiver_address]
         @order.receiver_postcode = params[:receiver_postcode]

         @session = Session.find(session[:progress_id]["$oid"].to_s)
         @order.user_id = @session.user_id
         @order.is_paid = 0
         @cart = Cart.find(session[:cart_id])
         @cart.update_attributes(:order_id => @order.id)

         @product_lines = ProductLine.where(:cart_id => @cart.id)
         amount = 0.to_f
         @product_lines.each do |product_line|
            product= Product.find(product_line.product_id)
            price = product_line.current_price.to_f
            quantity = product_line.quantity.to_f
            amount = price *quantity+ amount
         end
        
         @order.amount = amount
         @cart.order_id = @order.id 
          
             if @order.save
                 redirect_to :action => 'order_confirm',  order_id: @order.id
            else
                 render json: 'order generate faild'               
            end
       end
    end

  def address_confirm
    #@product_line = ProductLine.find('551b2a8d6c6f634b02000000')
    
  end

  def global_notice
    notice_type = params[:notice_type]
  end

  def order_confirm

    #render json: params[:order_id]
    @order = Order.find(params[:order_id])
    if params[:again]
      @new_order = Order.new
      @new_order = @order.dup
      @new_order.save

        @product_lines = ProductLine.where(cart_id: session[:cart_id])
        @cart = Cart.new
          @cart.order_id = @order.id
          @cart.save
        @product_lines.each do |line|
          line.update_attributes(cart_id: @cart.id)
          line.save
        end
        session[:cart_id] = @cart._id.to_s

        #again

                  if  session[:progress_id]
              if session[:cart_id].nil?
                cart = Cart.where(order_id: @new_order.id).first
                 @product_line = ProductLine.where(cart_id: cart.id).first
                else
                   @product_line = ProductLine.where(cart_id: session[:cart_id]).first
              end
              
              @product = Product.find(@product_line.product_id)
            else
               redirect_to root_url
            end


        #again
    else
      if  session[:progress_id]
      if session[:cart_id].nil?
        cart = Cart.where(order_id: @order.id).first
         @product_line = ProductLine.where(cart_id: cart.id).first
        else
           @product_line = ProductLine.where(cart_id: session[:cart_id]).first
      end
      

      @product = Product.find(@product_line.product_id)
    else
       redirect_to root_url
    end


    end
    
   
    #  #render json: @order

  end

  def regist
    session[:last_verifycode_time] = nil
    @user = User.new
  end

  def product_apply
    @product = Product.new
  end

  def on_product_apply
    @product = Product.new(product_apply_params);
    notice_type = 'hello'
    if @product.save
      respond_to do |format|
        format.html { redirect_to mobile_view_login_path, notice: '请先登录'}
      end
    else
      respond_to do |format|
        format.html { redirect_to mobile_view_login_path, notice: '请先登录'}
      end
    end
  end

  def send_verifycode
    internal = -1;
    if session[:last_verifycode_time]
      internal = Time.now.to_i - session[:last_verifycode_time].to_i
      if internal < 20
        render json: internal
        return
      end
    end
    
    session[:last_verifycode_time] = Time.now.to_i
    session[:mobile] = params[:mobile]
    
    verifycode_lib = [('0'..'9')].map{|i| i.to_a}.flatten
    verifycode = (0...6).map{ verifycode_lib[rand(verifycode_lib.length)] }.join

    session[:verifycode] = verifycode
    sms_verifycode = MobileText.new
    sms_verifycode.post("http://222.185.228.25:8000/msm/sdk/http/sendsms.jsp?username=JSMB260719&scode=515369&content=@1@=#{verifycode}&tempid=MB-2013102300&mobile=#{params[:mobile]}",nil)
    render json: 1
  end

  def auth_login
    @user = User.new
    get_params = params.require(:user).permit(:mobile, :verifycode,:encrypt_password,:username,:login_by)
    respond_to do |format|

      if get_params
        # 手机验证码（登录－伪注册）
        if get_params[:login_by] == 'verifycode' 
          if get_params[:verifycode] == session[:verifycode]
            @user = User.where(:mobile => get_params[:mobile]).first
            if @user
              @session =  Session.new
              @session.user_id = @user.id
              @session.username = @user.username
              @session.save
              session[:progress_id] = @session._id
              session[:username] = @session.username
              session[:verifycode] = nil
              format.html { redirect_to mobile_view_show_product_path }       
            else
              @user = User.new
              @user.mobile = get_params[:mobile]
              @user.username = get_params[:mobile]
              user_rand = rand(99999999)+user_const
              user_rand = user_rand.to_s
              @user.encrypt_password = Digest::MD5.hexdigest(user_rand)
              @user.save
              @session =  Session.new
              @session.user_id = @user.id
              @session.username = @user.username
              @session.save
              session[:progress_id] = @session._id
              session[:username] = @session.username
              session[:verifycode] = nil
              format.html { redirect_to mobile_view_show_product_path }
            end
            
          else
            session[:last_verifycode_time] = nil
            format.html { redirect_to mobile_view_login_path, notice: '验证码错误！' }
          end
          
        end
        # 账号密码登录
        if get_params[:login_by] == 'pwd'
          @user = User.where(:username => get_params[:username]).first
          if @user.nil?
            session[:last_verifycode_time] = nil
            format.html { redirect_to mobile_view_login_path, notice: '用户名或手机号不存在！' }
            
          else 
            if @user.encrypt_password == get_params[:encrypt_password]
              @session =  Session.new
              @session.user_id = @user.id
              @session.username = @user.username
              @session.save
              session[:progress_id] = @session.id
              session[:username] = @session.username
              session[:last_verifycode_time] = nil
              format.html { redirect_to mobile_view_show_product_path, notice: '登录成功' }
              
            else
              session[:last_verifycode_time] = nil
              format.html { redirect_to mobile_view_login_path, notice: '密码错误！' }
              
            end
            
          end
          
        end
      else
        format.html { redirect_to mobile_view_login_path, notice: '未知错误'}
      end
    end
    
    share_node = Node.where(user_id: @user.id).first
   

    #生成新的节点
    if session[:from_node]
      super_node = Node.find(session[:from_node])
      if share_node
      else
        share_node = Node.new
        share_node.user_id = @user.id
        share_node.a_node = super_node.id
        share_node.level = super_node.level.to_i + 1
        if super_node.a_node
          share_node.b_node = super_node.a_node
        end
        if super_node.b_node
          share_node.c_node = super_node.b_node
        end
        share_node.origin_node = super_node.origin_node
        share_node.save
      end
    else
       if share_node.nil?
          share_node =Node.new
          share_node.user_id = @user.id
          share_node.level =1
          origin_node = share_node.generate_origin_node
          share_node.save
       end
    
    end#end of session[:from_node]
  end#end of auth_login

  def check_verifycode
    if session[:mobile] == params[:mobile]
      if session[:verifycode].downcase == params[:verifycode].downcase
        render json: 1
      else
        render json: 0
      end
    else
      render json: 2
    end
  end

  def send_verifycode
    internal = -1;
    if session[:last_verifycode_time]
      internal = Time.now.to_i - session[:last_verifycode_time].to_i
      if internal < 60
        render json: internal
        return
      end
    end
    
    session[:last_verifycode_time] = Time.now.to_i
    session[:mobile] = params[:mobile]
    
    lib = [('0'..'9')].map{|i| i.to_a}.flatten
    verifycode = (0...6).map{ lib[rand(lib.length)] }.join

    session[:verifycode] = verifycode
    sms_verifycode = MobileText.new
    sms_verifycode.post("http://222.185.228.25:8000/msm/sdk/http/sendsms.jsp?username=JSMB260719&scode=515369&content=@1@=#{verifycode}&tempid=MB-2013102300&mobile=#{params[:mobile]}",nil)
    render json: 1
  end

  def check_verifycode
    if session[:mobile] == params[:mobile]
      if session[:verifycode].downcase == params[:verifycode].downcase
        render json: 1
      else
        render json: 0
      end
    else
      render json: 2
    end
  end

  def dologin
    
  end

  def about
    render 'about'
  end

  def boss_school
    render 'yeepay_school'
  end

  def yeepay_school

  end

  def protocol

  end

   

  private
  
  def get_user_agent
  	session[:user_agent] ||= request.user_agent
    if session[:user_agent].include?('Macintosh') || session[:user_agent].include?('Windows')
      respond_to do |format|
        format.html { redirect_to root_url, notice: '页面已经切换到电脑版本' }
      end
    end#if
  end#get_user_agent
  
  def check_user_session
    if session[:username]
    else
      respond_to do |format|
        format.html { redirect_to mobile_view_login_path, notice: '请先登录'  }
      end
    end
  end



  def product_apply_params
    params.require(:product).permit(:name, :price, :contract_person, :contract_person_mobile, :express_price, :address)
  end
  def user_const
    89
  end

end
