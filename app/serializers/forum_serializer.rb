class ForumSerializer < ActiveModel::Serializer
  ## Attributes ##
  attributes :id, :title, :subject, :expiry_date, :release_date,
             :tags, :expiry_date, :comments, :total_comments, :total_forums, :full_name, :medium_poster, :thumb_poster

  ## Associations ##
  has_many :comments

  ## Instance Methods ##
  def total_comments
    object.comments.size
  end

  def total_forums
    Forum.all.size
  end

  def full_name
    User.first.full_name
  end

  def medium_poster
    object.medium_image
  end

  def thumb_poster
    object.thumb_image
  end
end
