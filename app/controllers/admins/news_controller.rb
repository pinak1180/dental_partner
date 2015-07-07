class Admins::NewsController < AdminBaseController
  before_action :set_admins_news, only: [:show, :edit, :update, :destroy, :mark_not_allowed]
  before_action :set_form_details, only: [:new, :edit, :create, :update]
  add_breadcrumb 'News', :admins_news_index_path, title: 'News'

  def index
    @admins_news = News.unscoped.includes(:views)
  end

  def show
    @admins_news.notifications.update_all(read: true)
    @news_comments = @admins_news.comments.includes(:user).page(params[:page]).per(5)
    @comment = @admins_news.comments.build
    add_breadcrumb @admins_news.title.titlecase, admins_news_path(@admins_news.id)
  end

  def new
    @admins_news = News.new
    add_breadcrumb 'New Article', new_admins_news_path, title: 'News'
  end

  def edit
  end

  def create
    @admins_news = News.new(admins_news_params)
    if @admins_news.save
      redirect_to admins_news_path(@admins_news), notice: 'News was successfully created.'
    else
      render :new
    end
  end

  def update
    if @admins_news.update(admins_news_params)
      redirect_to admins_news_path(@admins_news), notice: 'News was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @admins_news.destroy
    redirect_to admins_news_index_url, notice: 'News was successfully destroyed.'
  end

  def mark_not_allowed
    @comment = @admins_news.comments.find(params[:c_id])
    @comment.update(allowed: !@comment.allowed)
    redirect_to admins_news_path(@admins_news.id), notice: "The Comment is Reported"
  end

  private

  def set_admins_news
    @admins_news = News.unscoped.find(params[:id])
  end

  def admins_news_params
    params.require(:news).permit(:content, :tags, :send_push, :poster_avatar, :expiry_date, :release_date, :link, :pdf, :title, :author_name, :send_to_all, position_ids: [], access_level_ids: [], department_ids: [], practise_code_ids: [], direct_report_ids: [], media_files_attributes: [ :id, :fileable_id, :fileable_type, :file, :_destroy ])
  end
end
