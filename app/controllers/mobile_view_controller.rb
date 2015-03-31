class MobileViewController < ApplicationController
  layout 'purestyle'
  before_action :check_user_session, except: [:login, :regist, :index, :about_boss]
  #before_action :get_user_agent, only: [:index]
  skip_before_filter :verify_authenticity_token, only: [:buy_where]
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
      @product = Product.find("5518a4eb6c6f635746000000")
    end

    if session[:username]
       @product = Product.find("5518a4eb6c6f635746000000")
    else
      respond_to do |format|
          format.html { render 'login', notice: '请先登录'  }
      end  
    end
  end

  def buy_where
    if params[:quantity] and params[:product_id]
      @product_line = ProductLine.new
      @product_line.quantity = params[:quantity]
      @product_line.product_id = params[:product_id]
        if @product_line.save
          respond_to do |format|
            format.html { redirect_to mobile_view_address_confirm_path, notice: '请确认订单'  }
          end  
        else
          respond_to do |format|
            format.html { render 'login', notice: '请先登录'  }
          end  
        end
    end
  end

  def address_confirm
    
  end

  def regist
    @user = User.new
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

end
