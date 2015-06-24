class News < ActiveRecord::Base
  include RecipientFilter
  #include Notifications
  include PublicActivity::Common
  acts_as_commentable
  acts_as_votable
  default_scope { where{(release_date <= Date.today) & ((expiry_date >= Date.today) | (expiry_date == nil))}.latest }

  ## Associations ##
  has_many :notifications, -> { where(trackable_type: "News") }, class: PublicActivity::Activity, foreign_key: :trackable_id, dependent: :destroy
  has_many  :media_files, as: :fileable, dependent: :destroy

  ## Validations ##
  validates :title, :content, :poster_avatar, presence: true
  validate :atleast_single_reciptient, :correct_expiry_date
  has_attached_file :poster_avatar,
                    styles: { medium: '300x300>', thumb: '100x100>', header: '1100x300#' },
                    default_url: 'cover_default.jpg'
  validates_attachment_content_type :poster_avatar, content_type: /\Aimage\/.*\Z/

  ## Nested Attributes ##
  accepts_nested_attributes_for :media_files, allow_destroy: true

  ## Instance Methods ##
  def medium_image
    ENV['HOST'] + poster_avatar.url(:medium)
  end

  def thumb_image
    ENV['HOST'] + poster_avatar.url(:thumb)
  end
end
