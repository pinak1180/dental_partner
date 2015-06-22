class MediaFile < ActiveRecord::Base

  ## Associations ##
  belongs_to :fileable, polymorphic: true

  ## Validations ##
  validates :file, presence: true
  has_attached_file :file,
                    styles: { medium: '300x300>', thumb: '100x100>', header: '1100x300#' },
                    default_url: 'cover_default.jpg'
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/
end
