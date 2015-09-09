class Admins::PractiseCodesController < ApplicationController
  before_action :set_admins_practise_code, only: [:show, :edit, :update, :destroy]

  # GET /admins/practise_codes
  # GET /admins/practise_codes.json
  def index
    @admins_practise_codes = PractiseCode.all
  end

  # GET /admins/practise_codes/1
  # GET /admins/practise_codes/1.json
  def show
  end

  # GET /admins/practise_codes/new
  def new
    @admins_practise_code = PractiseCode.new
  end

  # GET /admins/practise_codes/1/edit
  def edit
  end

  # POST /admins/practise_codes
  # POST /admins/practise_codes.json
  def create
    @admins_practise_code = PractiseCode.new(admins_practise_code_params)

    respond_to do |format|
      if @admins_practise_code.save
        format.html { redirect_to admins_practise_codes_path, notice: 'Practise code was successfully created.' }
        format.json { render :show, status: :created, location: @admins_practise_code }
      else
        format.html { render :new }
        format.json { render json: @admins_practise_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/practise_codes/1
  # PATCH/PUT /admins/practise_codes/1.json
  def update
    respond_to do |format|
      if @admins_practise_code.update(admins_practise_code_params)
        format.html { redirect_to admins_practise_codes_path, notice: 'Practise code was successfully updated.' }
        format.json { render :show, status: :ok, location: @admins_practise_code }
      else
        format.html { render :edit }
        format.json { render json: @admins_practise_code.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admins_practise_code
      @admins_practise_code = PractiseCode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admins_practise_code_params
      params[:practise_code].permit(:code)
    end
end
