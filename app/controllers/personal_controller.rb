class PersonalController < ApplicationController
  def index
      
  end

  def my_account
  	@user = User.find(params[:user_id])
  end

  def myorder
  end

  def account_setting
  end
end
