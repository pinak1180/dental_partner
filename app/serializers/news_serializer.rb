class NewsSerializer < ActiveModel::Serializer

  ## Attributes ##
  attributes :id, :title, :content, :tags, :expiry_date, :comments, :link,
             :total_comments, :medium_poster, :thumb_poster, :release_date,
             :liked_by_user, :author_name, :department, :tags, :original_poster,
             :created_on, :pdf_url, :admin_dp, :admin_name

  ## Association ##
  has_many :comments
  has_many :media_files, as: :fileable

  ## Instance Methods ##
  def comments
    object.comments.allowed
  end

  def pdf_url
    object.pdf.present? ? ENV['HOST']+object.pdf.url : ''
  end

  def total_comments
    object.comments.allowed.size
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

  def created_on
    object.print_created_at
  end

  def liked_by_user
    ActsAsVotable::Vote.where(voter_id:serialization_options[:user].id,votable_id: object.id,  vote_flag: true).present?
  end

  def department
    object.departments
  end
  def admin_dp
    ENV['HOST'] + User.admin.avatar.url
  end

  def admin_name
    admin = User.admin
    admin.full_name.present? ? admin.full_name : "Alana"
  end
end
