class ProductsController < ApplicationController
  before_action :set_product #, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:destroy, :create]
  layout 'admin.html.erb'

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
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

    def set_product
      if session[:adminname] == nil and session[:username] == nil
        respond_to do |format|
          format.html { redirect_to admins_path }
        end
      else
        if params[:action].to_s == 'show' or params[:action].to_s == 'edit' or params[:action].to_s == 'update' or params[:action].to_s == 'destroy'
          @product = Product.find(params[:id])
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price, :boss_price, :origin_price, :contract_person, :express_price, :address, :post_address, :user_id,:catalog_id, :is_pass, :description,:contract_person_mobile)
    end
end
