class Api::V1::DentalPartner::ForumsController < Api::V1::BaseController
  before_filter :authentication_user_with_authentication_token

  def index
    @forum  = ::Forum.valid_feeds(@current_user.id)
    render json: @forum, each_serializer: ForumSerializer
  end

  def show
    @forum = ::Forum.valid_feeds(@current_user.id).find(params[:id])
    render json: @forum
  end
end
