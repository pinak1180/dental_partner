class Message < ActiveRecord::Base
  include RecipientFilter

  ## Validations ##
  validates :message_body, presence: true

  ## Associations ##
  belongs_to :sender, class: User, foreign_key: 'sender_id'
  belongs_to :receiver, class: User, foreign_key: 'receiver_id'
  belongs_to :parent, class: Message, foreign_key: 'parent_id'
  has_many   :child_messages, class: Message, foreign_key: 'parent_id'


  ## Instance Methods ##
  def display_errors
    errors.full_messages.join(',')
  end
end
