class ResponseDetailSerializer < ActiveModel::Serializer
  attributes :id, :question_id, :answer_id, :response
  belongs_to :response
  belongs_to :answer
end
