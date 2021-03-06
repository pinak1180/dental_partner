class ApiIndexRenderer
  attr_reader :name, :link_ref, :method_type

  def initialize(name, link_ref, method_type)
    @name        = name
    @link_ref    = link_ref
    @method_type = method_type
  end

  class << self
    def dental_partner_api_index
      index_arr = []
      index_arr << ApiIndexRenderer.new('Login', 'login', 'POST')
      index_arr << ApiIndexRenderer.new('Forgot Password', 'forgot_password', 'POST')
      index_arr << ApiIndexRenderer.new('Change Password', 'change_password', 'POST')
      index_arr << ApiIndexRenderer.new('Get All News', 'news_index', 'GET')
      index_arr << ApiIndexRenderer.new('Get news by id', 'news_show', 'GET')
      index_arr << ApiIndexRenderer.new('Create Comment', 'create_comment', 'POST')
      index_arr << ApiIndexRenderer.new('Get All Forums', 'forums_index', 'GET')
      index_arr << ApiIndexRenderer.new('Get Forums by id', 'forums_show', 'GET')
      index_arr << ApiIndexRenderer.new('Create Comment for Forum', 'create_comment_forum', 'POST')
      index_arr << ApiIndexRenderer.new('Like article', 'like_article', 'POST')
      index_arr << ApiIndexRenderer.new('Dislike article ', 'dislike_article', 'delete')
      index_arr << ApiIndexRenderer.new('Follow Forum', 'follow_forum', 'POST')
      index_arr << ApiIndexRenderer.new('Unfollow Forum', 'unfollow_forum', 'delete')
      index_arr << ApiIndexRenderer.new('Get Survey by id', 'surveys_show', 'GET')
      index_arr << ApiIndexRenderer.new('Get All Surveys', 'surveys_index', 'GET')
      index_arr << ApiIndexRenderer.new('Get All Contacts', 'contacts', 'GET')
      index_arr << ApiIndexRenderer.new('List Messages', 'message_index', 'GET')
      index_arr << ApiIndexRenderer.new('Get Message Detail', 'message_show', 'GET')
      index_arr << ApiIndexRenderer.new('Reply/Send Message', 'message_create', 'POST')
      index_arr << ApiIndexRenderer.new('Mark as Deleted Message', 'message_delete', 'DELETE')
      index_arr << ApiIndexRenderer.new('Mark as Read Message', 'message_read', 'POST')
      index_arr << ApiIndexRenderer.new('Logout', 'logout', 'GET')
      index_arr
    end
  end
end
