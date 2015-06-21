class Response < ActiveRecord::Base

  ## Associations ##
  has_many   :response_details, dependent: :destroy, inverse_of: :response
  belongs_to :survey, inverse_of: :responses
  has_many   :questions, through: :survey

  ## Validations ##
  validates :user_id, :survey_id, presence: true
  validates :survey_id, uniqueness: { scope: [:user_id], message: "can be responded only once" }
  #validates_presence_of :response_details
  #validate  :correct_response

  ## Nested Attributes ##
  accepts_nested_attributes_for :response_details,:allow_destroy => :true

  ## Instance Methods ##
  def display_errors
    errors.full_messages.join(',')
  end

  private
  def correct_response
    if survey_id.present?
      quests = survey.questions
      puts quests.inspect
      compulsory_questions = quests.compulsory_questions.ids
      puts compulsory_questions.inspect
      answered_questions = response_details.map(&:question_id)
      puts answered_questions.inspect
      puts "====#{answered_questions}======#{compulsory_questions}"
      puts compulsory_questions == answered_questions
      unless compulsory_questions == answered_questions
        errors.add(:base, "All compulsory questions need to be answered")
      end
    end
  end
end
