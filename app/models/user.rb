class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # #Associations##
  has_many :authentication_tokens, dependent: :destroy, inverse_of: :user

  ## Class Methods ##
  def self.invalid_credentials
    'Email or Password is not valid'
  end

  def self.authenticate_user_with_auth(email, password)
    return nil unless email.present? || password.present?
    u = User.find_by_email(email)
    (u.present? && u.valid_password?(password)) ? u : nil
  end

  # #instance methods
  def display_errors
    errors.full_messages.join(',')
  end
end
