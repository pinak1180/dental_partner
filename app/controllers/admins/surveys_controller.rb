class Admins::SurveysController < AdminBaseController
  before_action :set_survey, only: [:show, :edit, :update, :destroy]
  before_action :set_form_details, only: [ :new, :edit, :create, :update ]
  add_breadcrumb "Surveys", :admins_surveys_path

  def index
    @surveys = Survey.all.page params[:page]
  end

  def show
  end

  def new
    @survey = Survey.new
    @survey.questions.build
    add_breadcrumb "New Survey", new_admins_survey_path
  end

  def edit
  end

  def create
    @survey = Survey.new(survey_params)
    if @survey.save
      redirect_to admins_survey_path(@survey), notice: 'Survey was successfully created.'
    else
      render :new
    end
  end

  def update
    if @survey.update(survey_params)
      redirect_to admins_survey_path(@survey), notice: 'Survey was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @survey.destroy
    redirect_to admins_surveys_path, notice: 'Survey was successfully destroyed.'
  end

  private
    def set_survey
      @survey = Survey.find(params[:id])
    end

    def survey_params
      params.require(:survey).permit(:title, :description, :release_date, :expiry_date, :tags, position_ids: [], department_ids: [], practise_code_ids: [], direct_report_ids: [], access_level_ids: [], questions_attributes: [:survey_id, :id, :question, :compulsory, :_destroy, answers_attributes: [:id, :option, :_destroy]])
    end
end
