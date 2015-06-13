class ResponseDetail < ActiveRecord::Base
  ## Associations ##
  belongs_to :question
  belongs_to :answer
  belongs_to :response, inverse_of: :response_details

  ## Validations ##
  validates :question_id, :answer_id, presence: true
  validates :question_id, uniqueness: { scope: [:response_id], message: 'question can only answered once' }
  validates_presence_of :response
  private

  def correct_response
    if survey_id.present?
      quests = survey.questions
      puts quests.inspect
      compulsory_questions = quests.compulsory_questions.ids
      puts compulsory_questions.inspect
      answered_questions = response_details.pluck(:question_id)
      puts 'pinak'
      puts answered_questions.inspect
      puts "====#{answered_questions}======#{compulsory_questions}"
      unless compulsory_questions.include? answered_questions
        errors.add(:base, 'All compulsory questions need to be answered')
      end
    end
  end
  
end
