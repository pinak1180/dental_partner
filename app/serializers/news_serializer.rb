class NewsSerializer < ActiveModel::Serializer

  ## Attributes ##
  attributes :id, :title, :content, :tags, :expiry_date, :comments,
             :total_comments, :medium_poster, :thumb_poster,:release_date

  ## Association ##
  has_many :comments

  ## Instance Methods ##
  def total_comments
    object.comments.size
  end

  def medium_poster
    object.medium_image
  end

  def thumb_poster
    object.thumb_image
  end

  def liked_by_user
  end
end
