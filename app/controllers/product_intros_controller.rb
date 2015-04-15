class ProductIntrosController < ApplicationController
  before_action :set_product_intro, only: [:show, :edit, :update, :destroy]

  # GET /product_intros
  # GET /product_intros.json
  def index
    @product_intros = ProductIntro.all
  end

  # GET /product_intros/1
  # GET /product_intros/1.json
  def show
  end

  # GET /product_intros/new
  def new
    @product_intro = ProductIntro.new
  end

  # GET /product_intros/1/edit
  def edit
  end

  # POST /product_intros
  # POST /product_intros.json
  def create
    @product_intro = ProductIntro.new(product_intro_params)

    respond_to do |format|
      if @product_intro.save
        format.html { redirect_to @product_intro, notice: 'Product intro was successfully created.' }
        format.json { render :show, status: :created, location: @product_intro }
      else
        format.html { render :new }
        format.json { render json: @product_intro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_intros/1
  # PATCH/PUT /product_intros/1.json
  def update
    respond_to do |format|
      if @product_intro.update(product_intro_params)
        format.html { redirect_to @product_intro, notice: 'Product intro was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_intro }
      else
        format.html { render :edit }
        format.json { render json: @product_intro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_intros/1
  # DELETE /product_intros/1.json
  def destroy
    @product_intro.destroy
    respond_to do |format|
      format.html { redirect_to product_intros_url, notice: 'Product intro was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_intro
      @product_intro = ProductIntro.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_intro_params
      params[:product_intro]
    end
end
