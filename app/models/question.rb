class Question < ActiveRecord::Base

  ## Associations ##
  belongs_to :survey
  has_many   :answers

  ## Validations ##
  validates :question, presence: true
  validates :question, uniqueness: { case_sensitive: false }

  ## Nested Attributes ##
  accepts_nested_attributes_for :answers, allow_destroy: true
end
