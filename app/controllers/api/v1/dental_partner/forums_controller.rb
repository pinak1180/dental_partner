class Api::V1::DentalPartner::ForumsController < Api::V1::BaseController
  before_filter :authentication_user_with_authentication_token

  def index
    @forum  = ::Forum.valid_feeds(@current_user).latest.page(@page).per(@limit)
    current_user.mark_forums_viewed(@forum)
    render json: @forum, each_serializer: ForumSerializer, meta: { unread_count: 0 }
  end

  def show
    @forum = ::Forum.valid_feeds(@current_user).find(params[:id])
    render json: @forum
  end
end
