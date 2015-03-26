class MobileTextsController < ApplicationController
  before_action :set_mobile_text, only: [:show, :edit, :update, :destroy]

  # GET /mobile_texts
  # GET /mobile_texts.json
  def index
    @mobile_texts = MobileText.all
  end

  def send_sms
    @mobile_text = MobileText.new
    render plain: @mobile_text.post('http://222.185.228.25:8000/msm/sdk/http/sendsms.jsp?username=JSMB260719&scode=515369&content=@1@=hello,18126821118,您收到了吗？&tempid=MB-2013102300&mobile=18126821118',nil)
  end

  # GET /mobile_texts/1
  # GET /mobile_texts/1.json
  def show
  end

  # GET /mobile_texts/new
  def new
    @mobile_text = MobileText.new
  end

  # GET /mobile_texts/1/edit
  def edit
  end

  # POST /mobile_texts
  # POST /mobile_texts.json
  def create
    @mobile_text = MobileText.new(mobile_text_params)

    respond_to do |format|
      if @mobile_text.save
        format.html { redirect_to @mobile_text, notice: 'Mobile text was successfully created.' }
        format.json { render :show, status: :created, location: @mobile_text }
      else
        format.html { render :new }
        format.json { render json: @mobile_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mobile_texts/1
  # PATCH/PUT /mobile_texts/1.json
  def update
    respond_to do |format|
      if @mobile_text.update(mobile_text_params)
        format.html { redirect_to @mobile_text, notice: 'Mobile text was successfully updated.' }
        format.json { render :show, status: :ok, location: @mobile_text }
      else
        format.html { render :edit }
        format.json { render json: @mobile_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mobile_texts/1
  # DELETE /mobile_texts/1.json
  def destroy
    @mobile_text.destroy
    respond_to do |format|
      format.html { redirect_to mobile_texts_url, notice: 'Mobile text was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mobile_text
      @mobile_text = MobileText.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mobile_text_params
      params.require(:mobile_text).permit(:username, :scode, :mobile, :content, :extcode, :sendtime, :msgid, :msgtype, :signtag, :temid)
    end
end
