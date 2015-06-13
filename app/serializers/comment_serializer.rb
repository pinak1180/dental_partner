class CommentSerializer < ActiveModel::Serializer

  ## Attributes ##
  attributes :id,:comment,:created_at,:user_avatar_medium,:user_avatar_thumb

  def user_avatar_medium
    object.user.medium_image
  end

  def user_avatar_thumb
    object.user.thumb_image
  end
end
