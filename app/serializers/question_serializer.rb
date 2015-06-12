class QuestionSerializer < ActiveModel::Serializer

  ## Attributes ##
  attributes :id, :question, :compulsory, :answers

  ## Associations ##
  has_many :answers
end
