class CommentSerializer < ActiveModel::Serializer

  ## Attributes ##
  attributes :id,:comment,:created_at,:user_avatar_medium,:user_avatar_thumb,:full_name

  def user_avatar_medium
    object.user.medium_image
  end

  def user_avatar_thumb
    object.user.thumb_image
  end

  def full_name
    object.user.full_name
  end
end
