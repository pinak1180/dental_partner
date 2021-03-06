class Admins::ForumsController < AdminBaseController
  before_action :set_forum, only: [:show, :edit, :update, :destroy, :mark_not_allowed]
  before_action :set_form_details, only: [:new, :edit, :create, :update]
  add_breadcrumb 'Forums', :admins_forums_path

  def index
    @forums = Forum.unscoped.eager_load(comments: :user, views: :user)
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"forums.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def show
    @forum.notifications.update_all(read: true)
    @forum_comments = @forum.comments.includes(:user).page(params[:page]).per(5)
    @comment = @forum.comments.build
    add_breadcrumb @forum.title.titlecase, admins_forum_path(@forum)
  end

  def new
    @forum = Forum.new
    add_breadcrumb 'New Forum', new_admins_forum_path
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

  def mark_not_allowed
    @comment = @forum.comments.find(params[:c_id])
    @comment.update(allowed: !@comment.allowed)
    redirect_to admins_forum_path(@forum.id), notice: "The Comment is Reported"
  end

  private

  def set_forum
    @forum = Forum.unscoped.find(params[:id])
  end

  def forum_params
    params.require(:forum).permit(:title, :send_push, :subject, :tags, :expiry_date, :release_date, :poster_avatar, :send_to_all, position_ids: [], department_ids: [], practise_code_ids: [],individual_user_ids:[], direct_report_ids: [], access_level_ids: [])
  end
end
