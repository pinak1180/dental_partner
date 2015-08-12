class Message < ActiveRecord::Base
  include RecipientFilter
  include Notifications
  include PublicActivity::Common

  ## Validations ##
  validates :message_body, :receiver_id, presence: true
  has_attached_file :msg_attachment,
                    url: "/system/message/:basename.:extension"
  validates_attachment_content_type :msg_attachment,
                                    content_type: ['application/pdf', /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/ ],
                                    message: "Invalid File, only Pdfs and Images are valid"
  ## Associations ##
  belongs_to :sender, class: User, foreign_key: 'sender_id'
  belongs_to :receiver, class: User, foreign_key: 'receiver_id'
  belongs_to :parent, class: Message, foreign_key: 'parent_id'
  has_many :child_messages, class: Message, foreign_key: 'parent_id'
  has_many :notifications, -> { where(trackable_type: 'Message') }, class: PublicActivity::Activity, foreign_key: :trackable_id

  ## Scope ##
  scope :parent_messages, -> { where(parent_id: nil) }
  scope :trash_messages, -> { where(is_deleted: true) }
  scope :untrashed, -> { where(is_deleted: false) }

  ## Callbacks ##
  after_create :send_new_post_push

  ## Instance Methods ##
  def display_errors
    errors.full_messages.join(',')
  end

  def create_records
    users = User.where(id: direct_user_ids)
    receiving_users = receivers
    sending_user = sender
    receiving_users.each do |user|
      sending_user.sent_messages.build(receiver_id: user.id, message_body: message_body, msg_attachment: msg_attachment).save!
    end
    users.each do |user|
      sending_user.sent_messages.build(receiver_id: user.id, message_body: message_body, msg_attachment: msg_attachment).save!
    end
    (receiving_users.count + users.count) > 0 ? true : false
  end

  def short_message
    message_body.first(30)
  end

  def sent_at
    created_at.strftime('%d %b %Y, %l:%M %P')
  end

  def msg_attachment_url
    msg_attachment.present? ? ENV['HOST'] + msg_attachment.url : ''
  end

  def display_receiver
    admin = User.admin
    receiver == admin ? sender : receiver
  end

  def atleast_one_reciptient?
    return false unless (position_ids | department_ids | practise_code_ids | direct_report_ids | direct_user_ids).present?
    true
  end
end
