class AdminSessionsController < ApplicationController
  before_action :set_session, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:destroy, :create]

  layout 'admin'

  # GET /sessions
  # GET /sessions.json
  def index
    @admin_session = AdminSession.all
  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show
  end

  # GET /sessions/new
  def new
    #@notice = "注册成功，请登录！"
    @admin_session = AdminSession.new

  end

  # GET /sessions/1/edit
  def edit
  end

  def auth_admin_remote
    @admin_session = AdminSession.new
    @admin_session.adminname = session_params[:adminname]
    @admin = Admin.where(:adminname => @admin_session.adminname).first
    if @admin
      encrypt_password = @admin.encrypt_password
      @admin_session.admin_id = @admin.id
      if encrypt_password == params[:encrypt_password]
          if @admin_session.save
            session[:adminname] = @admin_session.adminname
            session[:admin_session_id] = @admin_session.id.to_s
            session[:group_id] = @admin.group_id
            redirect_to admins_path
          else
            render json: "登录信息有误，请重新登录"#5
          end
      else
        render json: "登录信息有误，请重新登录"#1
      end
    else
      render json: "登录信息有误，请重新登录"#2
    end
  end

  # POST /sessions
  # POST /sessions.json
  def create
    @admin_session = AdminSession.new
    @admin_session.adminname = session_params[:adminname]
    @admin = Admin.where(:adminname => @admin_session.adminname).first
    if @admin
      @admin = @admin.auth(params[:encrypt_password])
      @admin_session.user_id = @admin.id
      if @admin
        respond_to do |format|
          if @admin_session.save
            session[:adminname] = @admin_session.adminname
            session[:admin_session_id] = @admin_session.id.to_s
            format.html { redirect_to @admin_session, notice: 'Session was successfully created.' }
            format.json { render :show, status: :created, location: @admin_session }
          else
            format.html { render :new }
            format.json { render json: @admin_session.errors, status: :unprocessable_entity }
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
      if @admin_session.update(session_params)
        format.html { redirect_to @admin_session, notice: 'Session was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_session }
      else
        format.html { render :edit }
        format.json { render json: @admin_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    @admin_session.destroy
    session[:admin_session_id] = nil
    session[:adminname] = nil
    session[:group_id] = nil
    reset_session
    respond_to do |format| 
      format.html { redirect_to admins_path, notice: '客官慢走，下次再来啊！' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @admin_session = AdminSession.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
      params.permit(:adminname, :encrypt_password)
    end
end
