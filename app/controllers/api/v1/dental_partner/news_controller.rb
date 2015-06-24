class Api::V1::DentalPartner::NewsController < Api::V1::BaseController
  before_filter :authentication_user_with_authentication_token

  def index
    @news  = ::News.valid_feeds(@current_user).page(@page).per(@limit)
    render json: @news, each_serializer: NewsSerializer, user: @current_user
  end

  def show
    @news = ::News.valid_feeds(@current_user).find(params[:id])
    render json: @news, user: @current_user
  end

end
