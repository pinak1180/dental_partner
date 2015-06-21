class Admins::NewsController < AdminBaseController
  before_action :set_admins_news, only: [:show, :edit, :update, :destroy]
  before_action :set_form_details, only: [:new, :edit, :create, :update]
  add_breadcrumb 'News', :admins_news_index_path, title: 'News'

  def index
    @admins_news = News.all.page params[:page]
  end

  def show
    @admins_news.notifications.update_all(read: true)
  end

  def new
    @admins_news = News.new
    add_breadcrumb 'New Article', new_admins_news_path, title: 'News'
  end

  def edit
  end

  def create
    @admins_news = News.new(admins_news_params)
    respond_to do |format|
      if @admins_news.save
        format.html { redirect_to admins_news_path(@admins_news), notice: 'News was successfully created.' }
        format.json { render :show, status: :created, location: @admins_news }
      else
        format.html { render :new }
        format.json { render json: @admins_news.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @admins_news.update(admins_news_params)
        format.html { redirect_to admins_news_path(@admins_news), notice: 'News was successfully updated.' }
        format.json { render :show, status: :ok, location: @admins_news }
      else
        format.html { render :edit }
        format.json { render json: @admins_news.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @admins_news.destroy
    respond_to do |format|
      format.html { redirect_to admins_news_index_url, notice: 'News was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_admins_news
    @admins_news = News.find(params[:id])
  end

  def admins_news_params
    params.require(:news).permit(:content, :tags, :send_push, :poster_avatar, :expiry_date, :release_date, :title, :author_name, position_ids: [], access_level_ids: [], department_ids: [], practise_code_ids: [], direct_report_ids: [])
  end
end
