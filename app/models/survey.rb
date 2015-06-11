class Survey < ActiveRecord::Base
  include RecipientFilter
  acts_as_commentable

  ## Associations ##
  has_many :questions
  has_one  :response, required: true

  ## Validations ##
  validates :title, :description, :release_date, :expiry_date, presence: true
  validate :atleast_single_reciptient, :correct_expiry_date

  ## Nested Attributes ##
  accepts_nested_attributes_for :questions, allow_destroy: true

end
