class MediaFileSerializer < ActiveModel::Serializer
  ## Attributes ##
  attributes :id, :medium_image, :thumb_image, :original_poster

  def original_poster
    object.original_image
  end

  def medium_image
    object.medium_image
  end

  def thumb_image
    object.thumb_image
  end
end
