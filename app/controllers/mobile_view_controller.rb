class MobileViewController < ApplicationController
  layout 'purestyle'
  before_action :check_user_session, except: [:login, :regist, :index, :about_boss, :send_verifycode]
  #before_action :get_user_agent, only: [:index]
  skip_before_filter :verify_authenticity_token, only: [:buy_where, :go_order, :order_confirm, :to_pay, :send_verifycode]
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
      @product = Product.find("551b2a8d6c6f634b02000000")
    end

    if session[:username]
       @product = Product.find("551b2a8d6c6f634b02000000")
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
         @session = Session.find(session[:progress_id])
         @order.user_id = @session.user_id
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
    render json: params[:mobile];
    session[:last_verifycode_time] = Time.now.to_i;
  end

  def dologin
    
  end

  def about
  end

  def boss_school
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
