class Admins::DashboardController < AdminBaseController
  def index
    @articles_count = News.unscoped.count
    @forums_count   = Forum.unscoped.count
    @surveys_count  = Survey.unscoped.count
    @users_count    = User.count
  end
end
