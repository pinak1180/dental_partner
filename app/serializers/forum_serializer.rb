class ForumSerializer < ActiveModel::Serializer

  ## Attributes ##
  attributes :id, :title, :subject, :expiry_date, :release_date,
             :tags, :expiry_date, :comments, :total_comments

  ## Associations ##
  has_many :comments

  ## Instance Methods ##
  def total_comments
    object.comments.size
  end

  
end
