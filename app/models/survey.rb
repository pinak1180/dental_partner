class Survey < ActiveRecord::Base
  include RecipientFilter
  include Notifications
  default_scope { where{((release_date <= Date.today) | (release_date == nil)) & ((expiry_date >= Date.today) | (expiry_date == nil))}.latest }

  ## Associations ##
  has_many :questions, dependent: :destroy
  has_many :responses, dependent: :destroy, inverse_of: :survey

  ## Validations ##
  validates :title, :description, :questions, presence: true
  validates :questions, :length => { :minimum => 1 }
  validate :atleast_single_reciptient, :correct_expiry_date

  ## Nested Attributes ##
  accepts_nested_attributes_for :questions, allow_destroy: true

  ## Instance Methods
  def recipient_percent
    ((recipient_number.to_f/receivers.size.to_f)*100).round(2) rescue 0
  end

  def recipient_number
    responses.size
  end
end
