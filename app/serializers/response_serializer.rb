class ResponseSerializer < ActiveModel::Serializer
  attributes :id, :survey_id, :created_at, :user_id, :response_details, :user
  belongs_to :survey
  belongs_to :user
end
