class SurveySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :release_date, :expiry_date
  has_many :questions
end
