class MobileViewController < ApplicationController
  layout 'purestyle'
  before_action :check_user_session, except: [:login, :regist, :index, :about_boss, :send_verifycode, :check_verifycode,:yeepay_school,:about]
  #before_action :get_user_agent, only: [:index]
  skip_before_filter :verify_authenticity_token, only: [:buy_where, :go_order, :order_confirm, :to_pay, :send_verifycode, :check_verifycode]
  def index
      if params[:notice]
        notice = params[:notice]
      end
  end

  def login
    if params[:d]
      session[:from_index] = '1'
      session[:ulaiber] = '1'
    end
    if session[:progress_id] and session[:from_index]
      respond_to do |format|
        format.html { redirect_to mobile_view_show_product_path  }
      end
    end
  end

  def show_product
    if params[:product_id]
      @product = Product.find(params[:product_id])
    end
    if session[:from_index]
      @product = Product.find("552276196c6f637c20060000")
    end

    if session[:username]
       @product = Product.find("552276196c6f637c20060000")
    else
      respond_to do |format|
          format.html { render 'login', notice: '请先登录'  }
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
            format.html { render 'login', notice: '请先登录'  }
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
         @order.user_id = session[:progress_id]
         @order.is_paid = 0
         @cart = Cart.find(session[:cart_id])
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
    @order = Order.find(params[:order_id])
    if  session[:progress_id]
       @product_line = ProductLine.where(cart_id: session[:cart_id]).first
      @product = Product.find(@product_line.product_id)
    else
       redirect_to root_url
    end
   
     #render json: @order
  end

  def regist
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
        format.html { render 'login', notice: '请先登录'}
      end
    else
      respond_to do |format|
        format.html { render 'login', notice: '请先登录'}
      end
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
        format.html { render 'login', notice: '请先登录'  }
      end
    end
  end



  def product_apply_params
    params.require(:product).permit(:name, :price, :contract_person, :contract_person_mobile, :express_price, :address)
  end

end
