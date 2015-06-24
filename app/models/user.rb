class User < ActiveRecord::Base
  include RecipientFilter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  default_scope { all }

  ## Associations ##
  has_many :authentication_tokens, dependent: :destroy, inverse_of: :user
  has_many :sent_messages, dependent: :destroy, class: Message, foreign_key: :sender_id
  has_many :received_messages, dependent: :destroy, class: Message, foreign_key: :receiver_id
  has_many :comments, dependent: :destroy
  has_many :notifications, class: PublicActivity::Activity, foreign_key: :recipient_id, dependent: :destroy

  ## Validations ##
  validates :first_name, :last_name, :phone, presence: true, unless: proc { |user| user.admin }
  validate  :atleast_single_reciptient

  before_validation :set_password, if: proc { |user| !user.admin && user.new_record? }
  after_create :send_welcome_mail, if: proc { |user| !user.admin }
  has_attached_file :avatar,
                    default_url: 'faceless.jpg',
                    styles: { medium: '300x300>', thumb: '100x100>' }

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  ## Scope ##
  scope :non_admins, -> { where(admin: false) }
  scope :admin, -> { find_by(admin: true) }
  scope :device_ids_not_null, -> { where("device_id <> ''") }
  scope :push_eligible_user, ->(type) { where(device_type: type).pluck(:device_id)}

  ## Custom Attributes ##
  attr_accessor :avatar1

  ## Class Methods ##
  def self.invalid_credentials
    'Email or Password is not valid'
  end

  def self.authenticate_user_with_auth(email, password)
    return nil unless email.present? || password.present?
    u = User.find_by_email(email)
    (u.present? && u.valid_password?(password)) ? u : nil
  end

  def decode_profile_picture_to_image_data(avatar1)
    cid                  = URI.unescape(avatar1)
    filename             = "avatar1#{Time.now.to_i}"
    file                 = File.open("#{Rails.root}/public/tmp/#{filename}.png", 'wb')
    temp2                = Base64.decode64(cid)
    file.write(temp2)
    file.close
    f                    = File.open("#{Rails.root}/public/tmp/#{filename}.png")
    self.avatar = f
    f.close
    File.delete("#{Rails.root}/public/tmp/#{filename}.png")
 end

  ## Instance methods ##
  def display_errors
    errors.full_messages.join(',')
  end

  def medium_image
    ENV['HOST'] + avatar.url(:medium)
  end

  def thumb_image
    ENV['HOST'] + avatar.url(:thumb)
  end

  def full_name
    format('%s %s', first_name, last_name)
  end

  def messages
    Message.where('sender_id = ? OR receiver_id = ?', id, id)
  end

  def import_users(filepath)
    importer = ImporterJob.perform_later("import_user", filepath)
  end

  def delete_users(filepath)
    importer = ImporterJob.perform_later("delete_users", filepath)
  end

  private
  def set_password
    self.password = Devise.friendly_token[0,8]
  end

  def send_welcome_mail
    UserMailer.send_credentials_email(self).deliver_now
  end
end
