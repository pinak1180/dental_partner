class Admins::ForumsController < AdminBaseController
  before_action :set_forum, only: [:show, :edit, :update, :destroy]
  before_action :set_form_details, only: [ :new, :edit, :create, :update ]

  def index
    @forums = Forum.all
  end

  def show
  end

  def new
    @forum = Forum.new
  end

  def edit
  end

  def create
    @forum = Forum.new(forum_params)
    if @forum.save
      redirect_to admins_forum_path(@forum), notice: 'Forum was successfully created.'
    else
      render :new
    end
  end

  def update
    if @forum.update(forum_params)
      redirect_to admins_forum_path(@forum), notice: 'Forum was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @forum.destroy
    redirect_to admins_forums_path, notice: 'Forum was successfully destroyed.'
  end

  private
  def set_forum
    @forum = Forum.find(params[:id])
  end

  def forum_params
    params.require(:forum).permit(:title, :subject, :expiry_date, :release_date, :tags, position_ids: [], department_ids: [], practise_code_ids: [], direct_report_ids: [], access_level_ids: [])
  end
end