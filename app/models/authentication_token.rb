class AuthenticationToken < ActiveRecord::Base
  ## Associations ##
  belongs_to :user, inverse_of: :authentication_tokens

  ## Validations ##
  validates :auth_token, :user_id, presence: true

  ## callback
  after_create :increse_signin_count

  ## Scope ##
  scope :current_authentication_token_for_user, ->(user_id, token) { joins(:user).where('users.id =? and auth_token = ?', user_id, token).readonly(false) }

  ## Class Methods ##
  class << self
    def generate_unique_token
      token = SecureRandom.hex(20)
      while AuthenticationToken.find_by_auth_token(token)
        token = SecureRandom.hex(20)
      end
      token
    end

    def find_user_from_authentication_token(token)
      u = where(auth_token: token)
      (u.present? && u.first.user.present?) ? u.first.user : nil
    end
  end

  def increse_signin_count
    User.increment_counter(:sign_in_count, user_id)
  end
end
