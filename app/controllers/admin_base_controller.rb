class AdminBaseController < ApplicationController
  before_action :authenticate_admin, :set_notification
  add_breadcrumb "Dashboard", :root_path, :options => { :title => "Dashboard" }

  private
  def authenticate_admin
    redirect_to new_user_session_path unless current_user.present?
  end

  def set_notification
    @notifications = current_user.notifications.includes(:owner, :trackable).where(read: false).order('created_at DESC')
  end

  def set_form_details
    @direct_reporters = User.non_admins.order(:email).pluck(:email, :id)
    @positions        = Position.order(:name).pluck(:name, :id)
    @access_levels    = AccessLevel.order(:level).pluck(:level, :id)
    @departments      = Department.order(:name).pluck(:name, :id)
    @practise_codes   = PractiseCode.order(:code).pluck(:code, :id)
  end
end
