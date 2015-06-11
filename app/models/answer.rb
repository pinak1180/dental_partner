class Answer < ActiveRecord::Base

  ## Associations ##
  belongs_to :question

  ## Validations ##
  validates :option, presence: true
  validates :option, uniqueness: { scope: [:question_id], case_sensitive: false }
end
