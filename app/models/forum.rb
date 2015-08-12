class Forum < ActiveRecord::Base
  include RecipientFilter
  include Notifications
  include PublicActivity::Common
  acts_as_commentable
  acts_as_votable

  default_scope { where{((release_date <= Date.today) | (release_date == nil)) & ((expiry_date >= Date.today) | (expiry_date == nil))}.latest }

  ## Associations ##
  has_many :notifications, -> { where(trackable_type: "Forum") }, class: PublicActivity::Activity, foreign_key: :trackable_id, dependent: :destroy
  has_many :views, as: :viewable, dependent: :destroy

  ## Validations ##
  validates :title, :subject, presence: true
  validate :atleast_single_reciptient, :correct_expiry_date
  has_attached_file :poster_avatar,
                    styles: { medium: '300x300>', thumb: '100x100>', header: '1100x300#' },
                    default_url: 'cover_default.jpg'
  validates_attachment_content_type :poster_avatar, content_type: /\Aimage\/.*\Z/

  ## Callbacks ##
  before_save :init_release_date
  after_create :send_new_post_push, if: :send_push?
  ## Instance Methods ##
  def original_image
    ENV['HOST'] + poster_avatar.url
  end

  def medium_image
    ENV['HOST'] + poster_avatar.url(:medium)
  end

  def thumb_image
    ENV['HOST'] + poster_avatar.url(:thumb)
  end

  def mark_user_follow(user)
    vote = votes_for.find_by(voter_id: user.id)
    liked_by user if !vote.present?
  end

  def init_release_date
    release_date ||= Date.today if new_record?
  end
end
