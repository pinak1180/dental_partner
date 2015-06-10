class ForumSerializer < ActiveModel::Serializer
  attributes :id, :title, :subject, :expiry_date, :release_date,
             :tags, :expiry_date, :comments, :total_comments

  has_many :comments

  def total_comments
    object.comments.size
  end  
end
