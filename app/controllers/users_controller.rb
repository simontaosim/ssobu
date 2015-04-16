
class UsersController < ApplicationController
  before_action :set_user #, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:destroy, :create, :remote_register]
  layout 'admin'
  #layout 'lightgreen'
  # GET /users
  # GET /users.json
  def index
    @perNum = perNum
    @users = User.order(created_at: :desc)
    @totalUsers = @users.count
    @totalPages = @totalUsers % perNum ? @totalUsers / perNum + 1 : @totalUsers / perNum
    if params[:lastPage]
      @curPageNo = @totalPages
      @users = @users.limit(perNum).offset((@curPageNo.to_i - 1)*perNum)
    elsif params[:pageup] and params[:curPageNo]
      @curPageNo = params[:curPageNo]
      @users = @users.limit(perNum).offset((@curPageNo.to_i - 1)*perNum)
    elsif params[:pagedown] and params[:curPageNo]
      @curPageNo = params[:curPageNo]
      @users = @users.limit(perNum).offset((@curPageNo.to_i - 1)*perNum)
    else
      @curPageNo = 1
      @users = @users.limit(perNum)
    end
  end

  def all_origin_users
    @users = User.all
  end

  def all_origin_users
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
    if session[:adminname] == nil
        respond_to do |format|
          format.html { redirect_to admins_path }
        end
      else
        @user = User.new
      end
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
<<<<<<< HEAD
    @user = User.new
    @user.email = user_register_params[:email]
    @user.username = user_register_params[:username]
    @user.encrypt_password = user_register_params[:encrypt_password]
=======
        @user = User.new
    @user.email = user_register_params[:email]
    @user.username = user_register_params[:username]
    if user_register_params[:password]
      @user.encrypt_password = @user.md5(user_register_params[:password])
    else
      @user.encrypt_password = user_register_params[:encrypt_password]
    end
>>>>>>> c6fe1f39e8332af8f745c0def6da8431bbe15e1e
    respond_to do |format|
      if @user.save
        create_account(@user.id)
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def register
    @user = User.new
    @user.email = user_register_params[:email]
    @user.username = user_register_params[:username]
    if user_register_params[:password]
      @user.encrypt_password = @user.md5(user_register_params[:password])
    else
      @user.encrypt_password = user_register_params[:encrypt_password]
    end
    if user_register_params[:reg_for] == 'mobile'
      @user.username = user_register_params[:mobile]
      @user.email = ''
<<<<<<< HEAD
      @user.mobile = user_register_params[:mobile]
=======
>>>>>>> c6fe1f39e8332af8f745c0def6da8431bbe15e1e
    else
      @user.mobile = ''
    end
    respond_to do |format|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
      if @user.save
        create_account(@user.id)
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
        create_account(@user.id)
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
      if !(params[:action].to_s == 'mobile_is_exist' or params[:action].to_s == 'username_is_exist' or params[:action].to_s == 'email_is_exist' or params[:action].to_s == 'register')
        if session[:adminname] == nil
          respond_to do |format|
            format.html { redirect_to admins_path }
          end
        else
          if params[:action].to_s == 'show' or params[:action].to_s == 'edit' or params[:action].to_s == 'update' or params[:action].to_s == 'destroy'
            @user = User.find(params[:id])
          end
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:role_id, :email, :third_party, :password, :password_confirm, :username, :from_mobile, :encrypt_password, :reg_for, :mobile, :is_boss)
    end

     def user_register_params
      params.require(:user).permit(:role_id, :email, :third_party, :password, :password_confirm, :username, :from_mobile, :encrypt_password, :reg_for, :mobile)
<<<<<<< HEAD
    end

    def create_account(user_id)
      account = Account.new
      account.user_id = user_id
      account.amount = 0
      account.save
      account
    end

    def perNum
      20
=======
>>>>>>> c6fe1f39e8332af8f745c0def6da8431bbe15e1e
    end
end
