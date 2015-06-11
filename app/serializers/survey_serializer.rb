class SurveySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :release_date, :expiry_date, :questions
  has_many :questions
  has_one  :response
end
