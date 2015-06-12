class SurveySerializer < ActiveModel::Serializer
  ## Attributes ##
  attributes :id, :title, :description, :release_date, :expiry_date, :is_completed_by_user, :questions

  ## Virtual attributes ##
  params :user_id, :show_details

  ## Associations ##
  has_many :questions
  has_many :responses

  ## Instance Methods ##
  def attributes
    super.only(:id, :title, :description, :release_date, :exppiry_date, :is_completed_by_user) if @show_details
  end

  def is_completed_by_user
    object.responses.find_by(user_id: @user_id).present?
  end
end
