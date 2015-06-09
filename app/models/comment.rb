class Comment < ActiveRecord::Base
  include ActsAsCommentable::Comment

  belongs_to :commentable, polymorphic: true

  default_scope -> { order('created_at ASC') }

  # #validations
  validates_length_of :comment, minimum: 5, maximum: 200, allow_blank: true

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  # acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user

  # #instance methods
  def display_errors
    errors.full_messages.join(',')
  end
end
