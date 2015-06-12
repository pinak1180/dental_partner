class ResponseDetail < ActiveRecord::Base

  ## Associations ##
  belongs_to :question
  belongs_to :answer
  belongs_to :response

  ## Validations ##
  validates :question_id, :answer_id, presence: true
  validates :question_id, uniqueness: { scope: [ :response_id ], message: "question can only answered once" }
end
