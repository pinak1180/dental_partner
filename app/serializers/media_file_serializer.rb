class MediaFileSerializer < ActiveModel::Serializer
  ## Attributes ##
  attributes :id, :medium_image, :thumb_image

  def medium_image
    object.medium_image
  end

  def thumb_image
    object.thumb_image
  end
end
