class MobileViewController < ApplicationController
  layout 'purestyle'
  before_action :check_user_session, except: [:login, :regist, :index, :about_boss]
  #before_action :get_user_agent, only: [:index]
  skip_before_filter :verify_authenticity_token, only: [:buy_where, :go_order, :order_confirm]
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
      @cart = Cart.create
      @product_line.quantity = params[:quantity]
      @product_line.product_id = params[:product_id]
      @product_line.cart_id = @cart._id
      session[:cart_id] = @cart._id

        if @product_line.save
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
      if params[:receiver] and params[:telephone] and params[:detailAddr]
         @order  = Order.new
         @order.receiver = params[:receiver]
         @order.mobile =  params[:telphone]
         @order.detailAddr = params[:detailAddr]
          respond_to do |format|
             if @order.save
                 @cart = Cart.find(session[:cart_id])
                 @cart.order_id = @order._id 
                 format.html { redirect_to mobile_view_address_confirm_path,  order_id: @order_id  }
              else
                render json: 'order generate faild'
              end
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
    @order = Order.new
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

  def dologin
    
  end

  def about_boss
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

  def to_pay
    redirect_to root_url, order_id, user_id, user_agent, amount, product_name, product_description, product_log 
  end

  def product_apply_params
    params.require(:product).permit(:name, :price, :contract_person, :contract_person_mobile, :express_price, :address)
  end

end
