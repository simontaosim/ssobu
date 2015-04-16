class RolesController < ApplicationController
<<<<<<< HEAD
  before_action :set_role #, only: [:show, :edit, :update, :destroy]
=======
  before_action :set_role, only: [:show, :edit, :update, :destroy]
>>>>>>> c6fe1f39e8332af8f745c0def6da8431bbe15e1e
  skip_before_filter :verify_authenticity_token, only: [:destroy, :create, :remote_register]
  layout 'admin'
  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
  end

  # GET /roles/new
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles
  # POST /roles.json
  def create
    @role = Role.new(role_params)

    respond_to do |format|
      if @role.save
        format.html { redirect_to @role, notice: 'Role was successfully created.' }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to @role, notice: 'Role was successfully updated.' }
        format.json { render :show, status: :ok, location: @role }
      else
        format.html { render :edit }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url, notice: 'Role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      if session[:adminname] == nil and session[:username] == nil
        respond_to do |format|
          format.html { redirect_to admins_path }
        end
      else
        if params[:action].to_s == 'show' or params[:action].to_s == 'edit' or params[:action].to_s == 'update' or params[:action].to_s == 'destroy'
          @role = Role.find(params[:id])
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:name, :ability)
    end
end
