class OrdersController < ApplicationController
<<<<<<< HEAD
  before_action :set_order #, only: [:show, :edit, :update, :destroy]
skip_before_filter :verify_authenticity_token, only: [:destroy, :delivery]
=======
  before_action :set_order, only: [:show, :edit, :update, :destroy]
skip_before_filter :verify_authenticity_token, only: [:destroy]
>>>>>>> c6fe1f39e8332af8f745c0def6da8431bbe15e1e
  layout 'admin'
  # GET /orders
  # GET /orders.json

  def index
    # if params[:firstPage]
    #   @orders = Order.order(created_at: :desc).limit(perNum)
    # end
    # if params[:lastPage]
    @perNum = perNum
    @orders = Order.order(created_at: :desc)
    if params[:is_paid]
      session[:admin_is_paid] = params[:is_paid]
    end
    if params[:wait_to_delivery]
      session[:admin_wait_to_delivery] = params[:wait_to_delivery]
    end
    if session[:admin_is_paid] == "1"
      @orders = @orders.where(:is_paid => 1)
    end
    if session[:admin_is_paid] == "2"
      @orders = @orders.where(:is_paid => 0)
    end
    if session[:admin_wait_to_delivery] == "1"
      @orders = @orders.where(:delivery_time => nil)
    end
    @totalOrders = @orders.count
    @totalPages = @totalOrders % perNum ? @totalOrders / perNum + 1 : @totalOrders / perNum
    if params[:lastPage]
      @curPageNo = @totalPages
      @orders = @orders.limit(perNum).offset((@curPageNo.to_i - 1)*perNum)
    elsif params[:pageup] and params[:curPageNo]
      @curPageNo = params[:curPageNo]
      @orders = @orders.limit(perNum).offset((@curPageNo.to_i - 1)*perNum)
    elsif params[:pagedown] and params[:curPageNo]
      @curPageNo = params[:curPageNo]
      @orders = @orders.limit(perNum).offset((@curPageNo.to_i - 1)*perNum)
    else
      @curPageNo = 1
      @orders = @orders.limit(perNum)
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
     if params[:from_my_boss]
      respond_to do |format|
      format.html { redirect_to personal_center_index_path, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
      end
    else
      respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
      end
    
    end
  end

  def delivery
    if params[:order_id] != nil and params[:delivery_company] != nil and params[:delivery_number] != nil
      current_order = Order.find(params[:order_id])
      current_order.delivery_company = params[:delivery_company]
      current_order.delivery_number = params[:delivery_number]
      current_order.delivery_time = Time.now.to_s
      if current_order.save
        render json: 0
      else
        render json: 2
      end
    else
      render json: 1
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def is_login
      if session[:adminname] == nil
        respond_to do |format|
          format.html { redirect_to admins_path }
        end
      end
    end

    def set_order
      if session[:adminname] == nil and session[:progress_id] == nil
        respond_to do |format|
          format.html { redirect_to admins_path }
        end
      else
        if params[:action].to_s == 'show' or params[:action].to_s == 'edit' or params[:action].to_s == 'update' or params[:action].to_s == 'destroy'
          @order = Order.find(params[:id])
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:user_id, :post_address, :receiver_name,:receiver_mobile, :receiver_address, :receiver_postcode,  :amount, :is_paid)
    end

    def perNum
      20
    end

end
