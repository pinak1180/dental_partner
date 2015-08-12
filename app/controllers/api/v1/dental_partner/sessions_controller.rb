class Api::V1::DentalPartner::SessionsController < Api::V1::BaseController
  before_filter :authentication_user_with_authentication_token, only: [:destroy]

  def create
    @user = User.authenticate_user_with_auth(params[:email], params[:password])
    if @user.present?
      if params[:device_id] && params[:device_type].present?
        @user.check_duplicate_device_ids(params[:device_id],@user,params[:device_type])
      end
      render json: @user, token: true
    else
      render_json({ result: { messages: User.invalid_credentials, rstatus: 0, errorcode: 404 } }.to_json)
    end
  end

  def destroy
    @token = AuthenticationToken.current_authentication_token_for_user(@current_user.id, params[:authentication_token]).first
    if @token.present?
      @token.destroy
      render_json({ result: { messages: 'ok', rstatus: 1, errorcode: '' }, data: { messages: 'Logout Successfully!' } }.to_json)
    else
      render_json({ errors: "No user found with authentication_token = #{params[:authentication_token]}" }.to_json)
    end
  end
end
