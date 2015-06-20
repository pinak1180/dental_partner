class Message < ActiveRecord::Base
  include RecipientFilter

  ## Validations ##
  validates :message_body, :receiver_id, presence: true

  ## Associations ##
  belongs_to :sender, class: User, foreign_key: 'sender_id'
  belongs_to :receiver, class: User, foreign_key: 'receiver_id'
  belongs_to :parent, class: Message, foreign_key: 'parent_id'
  has_many   :child_messages, class: Message, foreign_key: 'parent_id'

  ## Scope ##
  scope :parent_messages, -> { where( parent_id: nil ) }
  scope :trash_messages, -> { where( is_deleted: true ) }
  scope :untrashed, -> { where( is_deleted: false ) }
  ## Instance Methods ##
  def display_errors
    errors.full_messages.join(',')
  end

  def create_records
    receiving_users = receivers
    sending_user = sender
    receiving_users.each do |user|
      sending_user.sent_messages.build(receiver_id: user.id, message_body: message_body).save!
    end
  end

  def short_message
    message_body.first(30)
  end

  def sent_at
    created_at.strftime("%d %b %Y, %l:%M %P")
  end

  def atleast_one_reciptient?
    return false unless (position_ids || department_ids || practise_code_ids || direct_report_ids).present?
    true
  end
end
