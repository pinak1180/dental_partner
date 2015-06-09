class NewsSerializer < ActiveModel::Serializer
  attributes :id, :content, :tags, :expiry_date, :comments, :total_comments
  has_many :comments

  def total_comments
    object.comments.size
  end
end
