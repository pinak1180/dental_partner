class ResponseDetail < ActiveRecord::Base
  ## Associations ##
  belongs_to :question
  belongs_to :answer
  belongs_to :response, inverse_of: :response_details

  ## Validations ##
  validates :question_id, :answer_id, presence: true
  validates :question_id, uniqueness: { scope: [:response_id], message: 'question can only answered once' }
  validates_presence_of :response

  ## Scope ##
  scope :answer_count, -> { joins(:answer).select("answers.option").group("answers.option").count }
end
