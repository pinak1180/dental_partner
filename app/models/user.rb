class User < ActiveRecord::Base
  include RecipientFilter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Associations ##
  has_many :authentication_tokens, dependent: :destroy, inverse_of: :user

  ## Validations ##
  validates :first_name, :last_name, :phone, :access_level_ids,
            :department_ids, :practise_code_ids, :position_ids, presence: true, unless: Proc.new { |user| user.admin }

  before_validation :set_password, if: Proc.new { |user| !user.admin && user.new_record? }
  after_create      :send_welcome_mail, if: Proc.new { |user| !user.admin }

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

  private
  def set_password
    self.password = Devise.friendly_token
  end

  def send_welcome_mail
    UserMailer.send_credentials_email(self).deliver_now
  end
end
