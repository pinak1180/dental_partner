class ForumSerializer < ActiveModel::Serializer

  ## Attributes ##
  attributes :id, :title, :subject, :expiry_date, :release_date,
             :tags, :expiry_date, :comments, :total_comments, :total_forums, :full_name

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



end
