class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :question, :compulsory, :answers
  has_many :answers
end
