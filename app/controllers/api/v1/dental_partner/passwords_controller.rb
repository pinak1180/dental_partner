class Api::V1::DentalPartner::PasswordsController < Api::V1::BaseController
  before_filter :authentication_user_with_authentication_token, only: [:change_password]
  def create
    if params[:email].present?
      @user = User.where('email = lower(?)', params[:email]).first
      if @user.present?
        @user.send_reset_password_instructions
        render_json({ result: { messages: 'ok', rstatus: 1, errorcode: '' }, data: { messages: 'You will receive an email with instructions about how to reset your password in a few minutes.' } }.to_json)
      else
        render_json({ result: { messages: "No user found with email #{params[:email]}", rstatus: 0, errorcode: 404 } }.to_json)
      end
    else
      render_json({ result: { messages: 'Email Address is required', rstatus: 0, errorcode: 404 } }.to_json)
    end
  end

  def change_password
    if (params[:current_password].present? && params[:password].present? && params[:password_confirmation].present? && params[:password].to_s.eql?(params[:password_confirmation].to_s))# || params[:avatar].present?
      @user = @current_user.update_with_password(current_password: params[:current_password], password: params[:password], password_confirmation: params[:password_confirmation])
      if params[:avatar].present?
       @current_user.avatar1 = @current_user.decode_profile_picture_to_image_data(params[:avatar])
       @current_user.save
     end
      if @user
        return render_json({ result: { messages: 'ok', rstatus: 1, errorcode: '' }, data: { messages: 'Settings have been saved' } }.to_json)
      else
        return render_json({ result: { messages: @current_user.display_errors, rstatus: 0, errorcode: 404 } }.to_json)
      end
    elsif (params[:avatar].present? && !(params[:current_password] && params[:password] && params[:password_confirmation]).present?)
        @current_user.avatar1 = @current_user.decode_profile_picture_to_image_data(params[:avatar])
        if   @current_user.save
          return render_json({ result: { messages: 'ok', rstatus: 1, errorcode: '' }, data: { messages: 'Settings have been saved' } }.to_json)
        else
          return render_json({ result: { messages: @current_user.display_errors, rstatus: 0, errorcode: 404 } }.to_json)
        end
      else
        return render_json({ result: { messages: 'Current Password and Password required or password does not match', rstatus: 0, errorcode: 404 } }.to_json)
      end
   end
end
#params[:password].to_s.eql?(params[:password_confirmation].to_s)
