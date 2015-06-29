class NewsSerializer < ActiveModel::Serializer

  ## Attributes ##
  attributes :id, :title, :content, :tags, :expiry_date, :comments,
             :total_comments, :medium_poster, :thumb_poster, :release_date,
             :liked_by_user, :author_name, :department, :tags, :original_poster

  ## Association ##
  has_many :comments
  has_many :media_files, as: :fileable

  ## Instance Methods ##
  def comments
    object.comments.allowed
  end

  def total_comments
    object.comments.size
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

  def liked_by_user
    ActsAsVotable::Vote.where(voter_id:serialization_options[:user].id,votable_id: object.id,  vote_flag: true).present?
  end

  def department
    object.departments
  end
end
