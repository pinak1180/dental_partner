class Admins::DirectReportsController < ApplicationController
  before_action :set_admins_direct_report, only: [:show, :edit, :update, :destroy]

  # GET /admins/direct_reports
  # GET /admins/direct_reports.json
  def index
    @admins_direct_reports = DirectReport.all
  end

  # GET /admins/direct_reports/1
  # GET /admins/direct_reports/1.json
  def show
  end

  # GET /admins/direct_reports/new
  def new
    @admins_direct_report = DirectReport.new
  end

  # GET /admins/direct_reports/1/edit
  def edit
  end

  # POST /admins/direct_reports
  # POST /admins/direct_reports.json
  def create
    @admins_direct_report = DirectReport.new(admins_direct_report_params)

    respond_to do |format|
      if @admins_direct_report.save
        format.html { redirect_to admins_direct_reports_path, notice: 'Direct report was successfully created.' }
        format.json { render :show, status: :created, location: @admins_direct_report }
      else
        format.html { render :new }
        format.json { render json: @admins_direct_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/direct_reports/1
  # PATCH/PUT /admins/direct_reports/1.json
  def update
    respond_to do |format|
      if @admins_direct_report.update(admins_direct_report_params)
        format.html { redirect_to admins_direct_reports_path, notice: 'Direct report was successfully updated.' }
        format.json { render :show, status: :ok, location: @admins_direct_report }
      else
        format.html { render :edit }
        format.json { render json: @admins_direct_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/direct_reports/1
  # DELETE /admins/direct_reports/1.json
  def destroy
    @admins_direct_report.destroy
    respond_to do |format|
      format.html { redirect_to admins_direct_reports_url, notice: 'Direct report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admins_direct_report
      @admins_direct_report = DirectReport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admins_direct_report_params
      params[:direct_report].permit(:name, :email)
    end
end
