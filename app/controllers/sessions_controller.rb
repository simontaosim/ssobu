class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :edit, :update, :destroy]
  #layout 'lightgreen'

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

  # POST /sessions
  # POST /sessions.json
  def create
    @session = Session.new
    @session.username = session_params[:username]
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
