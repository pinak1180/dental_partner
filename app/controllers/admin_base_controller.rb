class AdminBaseController < ApplicationController
  before_action :authenticate_admin, :set_notification
  add_breadcrumb 'Dashboard', :root_path, options: { title: 'Dashboard' }

  private

  def authenticate_admin
    unless current_user.present? && current_user.admin
      if current_user.present?
        sign_out current_user
        flash[:alert] = 'Your are restricted for access'
      end
      redirect_to new_user_session_path
    end
  end

  def set_notification
    @notifications = current_user.notifications.includes(:owner, :trackable).order('created_at DESC')
    @new_notifications = @notifications.where(read: false)
  end

  def set_form_details
    @direct_reporters = User.non_admins.order(:email).pluck(:email, :id)
    @positions        = Position.order(:name).pluck(:name, :id)
    @access_levels    = AccessLevel.order(:level).pluck(:level, :id)
    @departments      = Department.order(:name).pluck(:name, :id)
    @practise_codes   = PractiseCode.order(:code).pluck(:code, :id)
  end
end
