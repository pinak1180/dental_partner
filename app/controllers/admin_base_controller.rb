class AdminBaseController < ApplicationController
  before_action :authenticate_admin, :set_notification

  private
  def authenticate_admin
    redirect_to new_user_session_path unless current_user.present?
  end

  def set_notification
    @notifications = current_user.notifications.includes(:owner, :trackable).where(read: false)
  end

  def set_form_details
    @direct_reporters = User.non_admins.pluck(:email, :id)
    @positions        = Position.pluck(:name, :id)
    @access_levels    = AccessLevel.pluck(:level, :id)
    @departments      = Department.pluck(:name, :id)
    @practise_codes   = PractiseCode.pluck(:code, :id)
  end
end
