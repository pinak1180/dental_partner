class Admins::UsersController < AdminBaseController
  before_action :set_admins_user, only: [:show, :edit, :update, :destroy]
  before_action :set_form_details, only: [:new, :edit, :create, :update]
  add_breadcrumb 'Users', :admins_users_path

  def index
    @admins_users = User.non_admins
  end

  def show
  end

  def new
    @admins_user = User.new
    add_breadcrumb 'New User', new_admins_user_path
  end

  def edit
  end

  def create
    @admins_user = User.new(admins_user_params)
    if @admins_user.save
      redirect_to admins_user_path(@admins_user), notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    if @admins_user.update(admins_user_params)
      redirect_to admins_user_path(@admins_user), notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @admins_user.destroy
    redirect_to admins_users_url, notice: 'User was successfully destroyed.'
  end

  def update_password
    @user = current_user
    if @user.update_with_password(user_password_params)
      flash[:notice] = 'Password Changed Successfully .'
      sign_in @user, bypass: true
      redirect_to root_path
    else
      flash[:error] = 'Incorrect Password Provided.'
      redirect_to edit_user_registration_path
    end
  end

  def notifications
    add_breadcrumb 'Notifications', new_admins_user_path
    @admin_notifications = current_user.notifications.includes(:owner, :trackable).order('created_at DESC').page(params[:page]).per(10)
  end

  def import
    if params[:csv_file].present?
      current_user.import_users(params[:csv_file].path)
      redirect_to admins_users_path, notice: 'Users are being Imported, you will receive status soon by email'
    elsif params[:csv_delete_file].present?
      current_user.delete_users(params[:csv_delete_file].path)
      redirect_to admins_users_path, notice: 'Users are being Deleted, you will receive status soon by email'
    else
      redirect_to admins_users_url, alert: 'CSV missing'
    end
  end

  def notification_badge
    @notifications.update_all(read: true) if @notifications.present?
  end

  private
  def set_admins_user
    @admins_user = User.find(params[:id])
  end

  def admins_user_params
    params.require(:user).permit(:first_name, :last_name, :can_post_feed, :position_ids, :phone, :email, :postal_code, position_ids: [], access_level_ids: [], department_ids: [], practise_code_ids: [], direct_report_ids: [])
  end

  def user_password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
