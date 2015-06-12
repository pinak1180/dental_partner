class Response < ActiveRecord::Base

  ## Associations ##
  has_many   :response_details, dependent: :destroy, inverse_of: :response
  belongs_to :survey
  has_many   :questions, through: :survey

  ## Validations ##
  validates :user_id, :survey_id, presence: true
  validates :survey_id, uniqueness: { scope: [:user_id], message: "can be responded only once" }
  #validate  :correct_response

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
      puts "====#{answered_questions}======#{compulsory_questions}"
      if (compulsory_questions != answered_questions)
        errors.add(:base, "All compulsory questions need to be answered")
      end
    end
  end
end
