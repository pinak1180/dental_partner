class UserSerializer < ActiveModel::Serializer
  ## Attributes ##
  attributes :id, :first_name, :last_name, :phone, :email, :authentication_token
  ## Instance Methods ##
  def attributes
    puts serialization_options[:token] == true
    unless serialization_options[:token]
      super.except(:authentication_token)
    else
      super
  end
  end

  def authentication_token
    object.authentication_tokens
      .create(auth_token: AuthenticationToken.generate_unique_token)
      .auth_token
  end
end
