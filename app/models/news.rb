class News < ActiveRecord::Base
  include RecipientFilter
  include Notifications
  include PublicActivity::Common
  acts_as_commentable
  acts_as_votable

  ## Associations ##
  has_many :notifications, -> { where(trackable_type: "News") }, class: PublicActivity::Activity, foreign_key: :trackable_id

  ## Validations ##
  validates :title, :content, :poster_avatar, presence: true
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
