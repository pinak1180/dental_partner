class Api::V1::DentalPartner::SurveysController < Api::V1::BaseController
  before_filter :authentication_user_with_authentication_token

  def index
    @survey  = Survey.valid_feeds(@current_user.id)
    render json: @survey, each_serializer: SurveySerializer
  end

  def show
    @survey = Survey.valid_feeds(@current_user.id).find(params[:id])
    render json: @survey
  end
end
