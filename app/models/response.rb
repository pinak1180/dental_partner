class Response < ActiveRecord::Base

  ## Associations ##
  has_many :response_details

  ## Validations ##
  validates :user_id, :survey_id, presence: true
  validates :survey_id, uniqueness: { scope: [:user_id], message: "can be responded only once" }
end
