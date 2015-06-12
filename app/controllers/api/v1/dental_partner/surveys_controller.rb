class Api::V1::DentalPartner::SurveysController < Api::V1::BaseController
  before_filter :authentication_user_with_authentication_token

  def index
    @survey  = Survey.valid_feeds(@current_user).page(@page).per(@limit)
    @survey.user = @current_user
    @survey.show_details = false
    render json: @survey, each_serializer: SurveySerializer
  end

  def show
    @survey = Survey.valid_feeds(@current_user).find(params[:id])
    render json: @survey, serializer_params: { show_details: true, user_id: @current_user.id }
  end
end
