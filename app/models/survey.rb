class Survey < ActiveRecord::Base
  include RecipientFilter
  acts_as_commentable

  ## Associations ##
  has_many :questions, dependent: :destroy
  has_many :responses, dependent: :destroy, inverse_of: :survey

  ## Validations ##
  validates :title, :description, :release_date, :expiry_date, :questions, presence: true
  validates :questions, :length => { :minimum => 1 }
  validate :atleast_single_reciptient, :correct_expiry_date

  ## Nested Attributes ##
  accepts_nested_attributes_for :questions, allow_destroy: true

end
