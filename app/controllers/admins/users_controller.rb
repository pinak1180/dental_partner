class Admins::UsersController < AdminBaseController
  before_action :set_admins_user, only: [:show, :edit, :update, :destroy]

  def index
    @admins_users = User.all
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
    respond_to do |format|
      if @admins_user.save
        format.html { redirect_to @admins_user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @admins_user }
      else
        format.html { render :new }
        format.json { render json: @admins_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @admins_user.update(admins_user_params)
        format.html { redirect_to @admins_user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @admins_user }
      else
        format.html { render :edit }
        format.json { render json: @admins_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @admins_user.destroy
    respond_to do |format|
      format.html { redirect_to admins_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_admins_user
      @admins_user = User.find(params[:id])
    end

    def admins_user_params
      params.require(:admins_user).permit(:first_name, :last_name, :position_ids, :phone, :email, :postal_code, :access_level_ids, :department_ids, :practise_code_ids, :direct_report_ids, :postal_code)
    end
end
