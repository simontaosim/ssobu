class ProvinceStatesController < ApplicationController
  before_action :set_province_state, only: [:show, :edit, :update, :destroy]

  # GET /province_states
  # GET /province_states.json
  def index
    @province_states = ProvinceState.all
  end

  # GET /province_states/1
  # GET /province_states/1.json
  def show
  end

  # GET /province_states/new
  def new
    @province_state = ProvinceState.new
  end

  # GET /province_states/1/edit
  def edit
  end

  # POST /province_states
  # POST /province_states.json
  def create
    @province_state = ProvinceState.new(province_state_params)

    respond_to do |format|
      if @province_state.save
        format.html { redirect_to @province_state, notice: 'Province state was successfully created.' }
        format.json { render :show, status: :created, location: @province_state }
      else
        format.html { render :new }
        format.json { render json: @province_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /province_states/1
  # PATCH/PUT /province_states/1.json
  def update
    respond_to do |format|
      if @province_state.update(province_state_params)
        format.html { redirect_to @province_state, notice: 'Province state was successfully updated.' }
        format.json { render :show, status: :ok, location: @province_state }
      else
        format.html { render :edit }
        format.json { render json: @province_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /province_states/1
  # DELETE /province_states/1.json
  def destroy
    @province_state.destroy
    respond_to do |format|
      format.html { redirect_to province_states_url, notice: 'Province state was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_province_state
      @province_state = ProvinceState.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def province_state_params
      params.require(:province_state).permit(:name)
    end
end
