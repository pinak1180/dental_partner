class Response < ActiveRecord::Base

  ## Associations ##
  has_many   :response_details, dependent: :destroy
  belongs_to :survey
  has_many   :questions, through: :survey

  ## Validations ##
  validates :user_id, :survey_id, presence: true
  validates :survey_id, uniqueness: { scope: [:user_id], message: "can be responded only once" }
  validate  :correct_response, :correct_questions, :correct_answers

  ## Nested Attributes ##
  accepts_nested_attributes_for :response_details

  ## Instance Methods ##
  def display_errors
    errors.full_messages.join(',')
  end

  private
  def correct_response
    if survey_id.present?
      quests = survey.questions
      compulsory_questions = quests.compulsory_questions.ids
      answered_questions = response_details.pluck(:question_id)
      if (compulsory_questions != answered_questions)
        errors.add(:base, "All compulsory questions need to be answered")
      end
    end
  end

  def correct_questions
    if survey_id.present?
      answered_questions = response_details.pluck(:question_id)
      if !(answered_questions.to_set.subset?(questions.ids.to_set))
        errors.add(:base, "Invalid Questions")
      end
    end
  end

  def correct_answers
    if survey_id.present?
      answer_ids = questions.joins(:answers).pluck("answers.id")
      answers = response_details.pluck(:answer_id)
      if !(answers.to_set.subset?(answer_ids.to_set))
        errors.add(:base, "Invalid Answers")
      end
    end
  end
end
