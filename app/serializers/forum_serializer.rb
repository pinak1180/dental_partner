class ForumSerializer < ActiveModel::Serializer
  ## Attributes ##
  attributes :id, :title, :subject, :expiry_date, :release_date,
             :tags, :expiry_date, :comments, :total_comments,
             :total_forums, :full_name, :medium_poster, :thumb_poster, :original_poster

  ## Associations ##
  has_many :comments

  ## Instance Methods ##
  def comments
    object.comments.allowed
  end

  def total_comments
    object.comments.size
  end

  def total_forums
    Forum.all.size
  end

  def full_name
    User.first.full_name
  end

  def original_poster
    object.original_image
  end

  def medium_poster
    object.medium_image
  end

  def thumb_poster
    object.thumb_image
  end
  def release_date
    object.print_release_date
  end

  def expiry_date
    object.print_expiry_date
  end
end
