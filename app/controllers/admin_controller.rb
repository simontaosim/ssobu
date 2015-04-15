class AdminController < ApplicationController
  layout 'admin'
  def index
  end

  def new_register
   @admin = Admin.new
  end

  def register
    @admin = Admin.new
    admin_params = params[:admin]
    respond_to do |format|
      if admin_params[:adminname] != nil and admin_params[:group_id] != nil and admin_params[:encrypt_password] != nil
        @admin.adminname = admin_params[:adminname]
        @admin.group_id = admin_params[:group_id]
        @admin.encrypt_password = admin_params[:encrypt_password]
        if @admin.save
          format.html { redirect_to admin_new_register_path }
        else
          format.html { redirect_to mobile_view_new_register_path }
        end

      else
        format.html { render json: params }
      end
    end

    

  end

  def show
    
  end

  def product_admin
    
  end

  def admins_admin
  end

  def order_admin
  end

  def address_admin
  end

  def role_admin
  end

  def node_admin
  end
end
