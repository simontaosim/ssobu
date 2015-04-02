
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:destroy, :create, :remote_register]
  #layout 'lightgreen'
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  def new_register
   @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def username_is_exist
     user = User.where(username: params[:username]).first
     if user
        render json: 0
     else
        render json: 1
     end
     
  end

  def email_is_exist
      user = User.where(email: params[:email]).first
     if user
        render json: 0
     else
        render json: 1
     end
  end

  def mobile_is_exist
      user = User.where(mobile: params[:mobile]).first
     if user
        render json: 0
     else
        render json: 1
     end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def register
    @user = User.new(user_register_params)
    if user_register_params[:password]
      @user.encrypt_password = user_register_params[:password]
    end
    @user.encrypt_password = user_register_params[:encrypt_password]
    respond_to do |format|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
      if @user.save
        if user_register_params[:from_mobile]
          format.html {redirect_to mobile_view_login_path, notice: '注册成功啦！请登录试试吧' }
        end
        format.html { redirect_to new_session_path, notice: '注册成功啦！请登录试试吧' }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def remote_register
    @user = User.new(user_register_params)
    @user.encrypt_password = @user.md5(user_register_params[:password]) 
  
      if @user.save
        render json: 1
      else
        render json: 0
      end
  end

  def personal_center
    @user = User.find(params[:user_id])    
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: '' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :third_party, :password, :password_confirm, :username)
    end

     def user_register_params
      params.require(:user).permit(:email, :third_party, :password, :password_confirm, :username, :from_mobile, :encrypt_password)
    end
end
