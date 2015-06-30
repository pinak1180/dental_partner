class UserSerializer < ActiveModel::Serializer
  ## Attributes ##
  attributes :id, :first_name, :last_name, :phone, :email, :authentication_token,
             :address,:fax_no, :avatar_image, :designation, :admin_id

  ## Instance Methods ##
  def attributes
    unless serialization_options[:token]
      super.except(:authentication_token, :admin_id)
    else
      super
    end
  end

  def avatar_image
    "#{ENV["HOST"]}#{object.avatar.url}"
  end

  def designation
    object.positions
  end

  def admin_id
    User.admin.id
  end

  def authentication_token
    object.authentication_tokens
      .create(auth_token: AuthenticationToken.generate_unique_token)
      .auth_token
  end
end
