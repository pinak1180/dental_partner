class Api::V1::DentalPartner::ResponsesController < Api::V1::BaseController
  before_filter :authentication_user_with_authentication_token, :set_survey

  def create
    return param_missing if !params[:response].present?
    @response = @survey.responses.build(response_params)
    @response.user_id = @current_user.id
    if @response.save
      render_json({ result: { messages: 'ok', rstatus: 1, errorcode: '' }, data: { messages: 'Your response created successfully' } }.to_json)
    else
      render_json({ result: { messages: @response.display_errors, rstatus: 0, errorcode: 404 } }.to_json)
    end
  end

  def param_missing
    render_json({ result: { messages: "response missing", rstatus: 0, errorcode: 404 } }.to_json)
  end

  private
    def set_survey
      @survey = Survey.valid_feeds(@current_user).find(params[:survey_id])
    end

    def response_params
      params[:response] = ActiveSupport::JSON.decode(params[:response])
      params.require(:response).permit(response_details_attributes: [:question_id, :answer_id])
    end
end
