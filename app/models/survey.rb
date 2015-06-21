class Survey < ActiveRecord::Base
  include RecipientFilter

  ## Associations ##
  has_many :questions, dependent: :destroy
  has_many :responses, dependent: :destroy, inverse_of: :survey

  ## Validations ##
  validates :title, :description, :questions, presence: true
  validates :questions, :length => { :minimum => 1 }
  validate :atleast_single_reciptient, :correct_expiry_date

  ## Nested Attributes ##
  accepts_nested_attributes_for :questions, allow_destroy: true

  ## instance methods

  def recipient_percent
    (receivers.size/recipient_number)*100
  end

  def recipient_number
    responses.size
  end

end
