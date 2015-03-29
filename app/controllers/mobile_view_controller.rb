class MobileViewController < ApplicationController
  layout 'purestyle'
  before_action :get_user_agent
  def index

  end

  def login
  end

  def regist
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
end
