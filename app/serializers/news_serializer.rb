class NewsSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :tags, :expiry_date, :comments,
  :total_comments, :medium_poster, :thumb_poster,:release_date
  has_many :comments

  def total_comments
    object.comments.size
  end

  def medium_poster
    object.medium_image
  end

  def thumb_poster
    object.thumb_image
  end
end
