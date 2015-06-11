class News < ActiveRecord::Base
  include RecipientFilter
  acts_as_commentable

  ## Associations ##

  ## Validations ##
  validates :title, :content, :poster_avatar, :release_date, :expiry_date, presence: true
  validate :atleast_single_reciptient, :correct_expiry_date
  has_attached_file :poster_avatar, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :poster_avatar, content_type: /\Aimage\/.*\Z/

  ## Instance Methods ##
  def medium_image
    ENV['HOST'] + poster_avatar.url(:medium)
  end

  def thumb_image
    ENV['HOST'] + poster_avatar.url(:thumb)
  end
end
