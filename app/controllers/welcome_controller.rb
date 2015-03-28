class WelcomeController < ApplicationController
  #layout 'purestyle'
  before_action :get_user_agent
  def index
  	if session[:user_agent].include?('Android') || session[:user_agent].include?('iPhone')
  		respond_to do |format|
        format.html { redirect_to mobile_view_index_path, notice: 'Session was successfully updated.' }
      end
  	end
  end

  private
  def get_user_agent
  	session[:user_agent] ||= request.user_agent
  end
end
