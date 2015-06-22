class Admins::DashboardController < AdminBaseController
  def index
    @articles_count = News.count
    @forums_count   = Forum.count
    @surveys_count  = Survey.count
    @users_count    = User.count
  end
end
