class WithdrawRecordsController < ApplicationController
  before_action :set_withdraw_record, only: [:show, :edit, :update, :destroy]
  layout 'admin'
  # GET /withdraw_records
  # GET /withdraw_records.json
  def index
    @withdraw_records = WithdrawRecord.all
  end

  # GET /withdraw_records/1
  # GET /withdraw_records/1.json
  def show
  end

  # GET /withdraw_records/new
  def new
    @withdraw_record = WithdrawRecord.new
  end

  # GET /withdraw_records/1/edit
  def edit
  end

  # POST /withdraw_records
  # POST /withdraw_records.json
  def create
    @withdraw_record = WithdrawRecord.new(withdraw_record_params)

    respond_to do |format|
      if @withdraw_record.save
        if params[:from_mobile_personal_center]
          redirect_to personal_center_withdraw_path
        else
          format.html { redirect_to @withdraw_record, notice: 'Withdraw record was successfully created.' }
          format.json { render :show, status: :created, location: @withdraw_record }
        end
      else
        format.html { render :new }
        format.json { render json: @withdraw_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /withdraw_records/1
  # PATCH/PUT /withdraw_records/1.json
  def update
    respond_to do |format|
      if @withdraw_record.update(withdraw_record_params)
        format.html { redirect_to @withdraw_record, notice: 'Withdraw record was successfully updated.' }
        format.json { render :show, status: :ok, location: @withdraw_record }
      else
        format.html { render :edit }
        format.json { render json: @withdraw_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /withdraw_records/1
  # DELETE /withdraw_records/1.json
  def destroy
    @withdraw_record.destroy
    respond_to do |format|
      format.html { redirect_to withdraw_records_url, notice: 'Withdraw record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_withdraw_record
      @withdraw_record = WithdrawRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def withdraw_record_params
      params.require(:withdraw_record).permit(:bank_name, :bank_card, :amount, :user_id, :done)
    end
end
