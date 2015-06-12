class SurveySerializer < ActiveModel::Serializer
  ## Attributes ##
  attributes :id, :title, :description, :release_date, :expiry_date, :is_completed_by_user, :questions

  ## Associations ##
  has_many :questions
  has_many :responses

  ## Instance Methods ##
  def attributes
    super.except(:questions) if serialization_options[:show_details]
  end

  def is_completed_by_user
    object.responses.find_by(user_id: serialization_options[:user_id]).present?
  end
end
