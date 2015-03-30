class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:destroy, :create]

  # GET /sessions
  # GET /sessions.json
  def index
    @sessions = Session.all
  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show
  end

  # GET /sessions/new
  def new
    #@notice = "注册成功，请登录！"
    @session = Session.new
  end

  # GET /sessions/1/edit
  def edit
  end

  def auth_user_remote
    @session = Session.new
    @session.username = session_params[:username]
    @user = User.where(:username => @session.username).first
    if @user
      password = @user.encrypt_password
      if password == params[:password]
          if @session.save
            session[:username] = @session.username
            session[:progress_id] = @session._id.to_s
            render json: 0
          else
            render json: 5
          end
      else
        render json: 1
      end
    else
      render json: 2
    end
  end

  # POST /sessions
  # POST /sessions.json
  def create
    @session = Session.new
    @session.username = session_params[:username]
    @user = User.where(:username => @session.username).first
    if @user
      @user = @user.auth(params[:password])
      if @user
        respond_to do |format|
          if @session.save
            session[:username] = @session.username
            session[:progress_id] = @session._id.to_s
            format.html { redirect_to @session, notice: 'Session was successfully created.' }
            format.json { render :show, status: :created, location: @session }
          else
            format.html { render :new }
            format.json { render json: @session.errors, status: :unprocessable_entity }
          end
        end
      else
        render json: '密码错误'
      end
    else
      render json: '用户名不存在'
    end
    
  end

  # PATCH/PUT /sessions/1
  # PATCH/PUT /sessions/1.json
  def update
    respond_to do |format|
      if @session.update(session_params)
        format.html { redirect_to @session, notice: 'Session was successfully updated.' }
        format.json { render :show, status: :ok, location: @session }
      else
        format.html { render :edit }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    @session.destroy
    session[:progress_id] = nil
    session[:username] = nil
    reset_session
    respond_to do |format| 
      format.html { redirect_to root_url, notice: '客官慢走，下次再来啊！' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = Session.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
      params.permit(:username, :password)
    end
end
