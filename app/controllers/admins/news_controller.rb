class Admins::NewsController < AdminBaseController
  before_action :set_admins_news, only: [:show, :edit, :update, :destroy]
  before_action :set_form_details, only: [ :new, :edit, :create, :update ]

  # GET /admins/news
  # GET /admins/news.json
  def index
    @admins_news = News.all
  end

  # GET /admins/news/1
  # GET /admins/news/1.json
  def show
  end

  # GET /admins/news/new
  def new
    @admins_news = News.new
  end

  # GET /admins/news/1/edit
  def edit
  end

  # POST /admins/news
  # POST /admins/news.json
  def create
    @admins_news = News.new(admins_news_params)

    respond_to do |format|
      if @admins_news.save
        format.html { redirect_to @admins_news, notice: 'News was successfully created.' }
        format.json { render :show, status: :created, location: @admins_news }
      else
        format.html { render :new }
        format.json { render json: @admins_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/news/1
  # PATCH/PUT /admins/news/1.json
  def update
    respond_to do |format|
      if @admins_news.update(admins_news_params)
        format.html { redirect_to @admins_news, notice: 'News was successfully updated.' }
        format.json { render :show, status: :ok, location: @admins_news }
      else
        format.html { render :edit }
        format.json { render json: @admins_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/news/1
  # DELETE /admins/news/1.json
  def destroy
    @admins_news.destroy
    respond_to do |format|
      format.html { redirect_to admins_news_index_url, notice: 'News was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admins_news
      @admins_news = News.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admins_news_params
      params.require(:news).permit(:content,:tags,:expiry_date,:release_date)
    end
end
