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
  end
end
