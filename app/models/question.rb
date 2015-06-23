class Question < ActiveRecord::Base

  ## Associations ##
  belongs_to :survey
  has_many   :answers, dependent: :destroy
  has_many   :response_details, dependent: :destroy

  ## Validations ##
  validates :question, :answers, presence: true
  validates :question, uniqueness: { case_sensitive: false }

  ## Nested Attributes ##
  accepts_nested_attributes_for :answers, allow_destroy: true

  ## Scopes ##
  scope :compulsory_questions, -> { where( compulsory: true ) }
end
