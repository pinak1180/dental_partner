class Forum < ActiveRecord::Base
  include RecipientFilter
  include PublicActivity::Common
  acts_as_commentable

  ## Associations ##
  has_many :notifications, -> { where(trackable_type: "Forum") }, class: PublicActivity::Activity, foreign_key: :trackable_id, dependent: :destroy

  ## Validations ##
  validates :title, :subject, presence: true
  validate :atleast_single_reciptient, :correct_expiry_date
  has_attached_file :poster_avatar, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: 'cover_default.jpg'
  validates_attachment_content_type :poster_avatar, content_type: /\Aimage\/.*\Z/

  ## Instance Methods ##
  def medium_image
    ENV['HOST'] + poster_avatar.url(:medium)
  end

  def thumb_image
    ENV['HOST'] + poster_avatar.url(:thumb)
  end
end
