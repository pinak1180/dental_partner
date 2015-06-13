class Api::V1::DentalPartner::UsersController < Api::V1::BaseController
  before_filter :authentication_user_with_authentication_token

  def index
    @user = User.non_admins.page(@page).per(@limit)
    render json: @user, each_serializer: UserSerializer
  end
end
