class Api::V1::DentalPartner::NewsController < Api::V1::BaseController
  before_filter :authentication_user_with_authentication_token

  def index
    @news  = ::News.all
    render json: @news, each_serializer: NewsSerializer
  end

  def show
    @news = ::News.first
    render json: @news
  end

end
