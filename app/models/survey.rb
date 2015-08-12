class Survey < ActiveRecord::Base
  include RecipientFilter
  include Notifications
  default_scope { where{((release_date <= Date.today) | (release_date == nil)) & ((expiry_date >= Date.today) | (expiry_date == nil))}.latest }

  ## Associations ##
  has_many :questions, dependent: :destroy
  has_many :responses, dependent: :destroy, inverse_of: :survey
  has_many :views, as: :viewable, dependent: :destroy

  ## Validations ##
  validates :title, :description, :questions, presence: true
  validates :questions, :length => { :minimum => 1 }
  validate :atleast_single_reciptient, :correct_expiry_date

  ## Scopes ##
  scope :incomplete_surveys_for_user, -> (user){ valid_feeds(user).eager_load(:responses).where("responses.user_id = ? OR responses.id = ?", user.id, nil) }

  ## Nested Attributes ##
  accepts_nested_attributes_for :questions, allow_destroy: true

  ## Virtual Attributes ##
  attr_accessor :is_completed

  ## Callbacks ##
  after_create :send_new_post_push

  ## Instance Methods ##
  def recipient_percent
    ((recipient_number.to_f/receivers.size.to_f)*100).round(2) rescue 0
  end

  def recipient_number
    responses.size
  end

  def completed?
    if release_date.present? && expiry_date.present?
      return true if release_date <= Date.today && expiry_date > Date.today
      false
    else
      receivers.count == responses.count
    end
  end

  def is_completed
    completed?
  end
end
