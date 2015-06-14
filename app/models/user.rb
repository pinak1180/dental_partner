class User < ActiveRecord::Base
  include RecipientFilter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Associations ##
  has_many :authentication_tokens, dependent: :destroy, inverse_of: :user
  has_many :sent_messages, dependent: :destroy, class: Message, foreign_key: :sender_id
  has_many :received_messages, dependent: :destroy, class: Message, foreign_key: :receiver_id

  ## Validations ##
  validates :first_name, :last_name, :phone, :access_level_ids,
            :department_ids, :practise_code_ids, :position_ids, presence: true, unless: Proc.new { |user| user.admin }

  before_validation :set_password, if: Proc.new { |user| !user.admin && user.new_record? }
  after_create      :send_welcome_mail, if: Proc.new { |user| !user.admin }
  has_attached_file :avatar,
                    default_url: "faceless.jpg",
                    styles: { medium: '300x300>', thumb: '100x100>' }

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  ## Scope ##
  scope :non_admins, -> { where(admin: false) }

  ## Class Methods ##
  def self.invalid_credentials
    'Email or Password is not valid'
  end

  def self.authenticate_user_with_auth(email, password)
    return nil unless email.present? || password.present?
    u = User.find_by_email(email)
    (u.present? && u.valid_password?(password)) ? u : nil
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

  private
  def set_password
    self.password = Devise.friendly_token
  end

  def send_welcome_mail
    UserMailer.send_credentials_email(self).deliver_now
  end
end
