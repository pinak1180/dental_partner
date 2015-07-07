class UserSerializer < ActiveModel::Serializer
  ## Attributes ##
  attributes :id, :first_name, :last_name, :phone, :email, :authentication_token,
             :address,:fax_no, :avatar_image, :designation, :admin_id,
             :survey_unread_count, :news_unread_count, :forum_unread_count

  ## Instance Methods ##
  def attributes
    unless serialization_options[:token]
      super.except(:authentication_token, :admin_id, :survey_unread_count, :news_unread_count, :forum_unread_count)
    else
      super
    end
  end

  def avatar_image
    "#{ENV["HOST"]}#{object.avatar.url}"
  end

  def designation
    object.positions
  end

  def admin_id
    User.admin.id
  end

  def authentication_token
    object.authentication_tokens
      .create(auth_token: AuthenticationToken.generate_unique_token)
      .auth_token
  end

  def survey_unread_count
    object.unread_surveys(Survey.valid_feeds(object).ids)
  end

  def forum_unread_count
    object.unread_forums(Forum.valid_feeds(object).ids)
  end

  def news_unread_count
    object.unread_news(News.valid_feeds(object).ids)
  end
end
