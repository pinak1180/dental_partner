class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :phone, :email, :authentication_token

  def authentication_token
    object.authentication_tokens
      .create(auth_token: AuthenticationToken.generate_unique_token)
      .auth_token
  end
end
