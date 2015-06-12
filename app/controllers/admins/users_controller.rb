class Admins::UsersController < AdminBaseController
  before_action :set_admins_user, only: [:show, :edit, :update, :destroy]
  before_action :set_form_details, only: [ :new, :edit, :create, :update ]

  def index
    @admins_users = User.non_admins.page params[:page]
  end

  def show
  end

  def new
    @admins_user = User.new
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

  private
    def set_admins_user
      @admins_user = User.find(params[:id])
    end

    def admins_user_params
      params.require(:user).permit(:first_name, :last_name, :position_ids, :phone, :email, :postal_code, position_ids: [], access_level_ids: [], department_ids: [], practise_code_ids: [], direct_report_ids: [])
    end
end
