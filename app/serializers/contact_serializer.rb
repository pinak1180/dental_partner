class ContactSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :phone,
             :positions, :departments, :avatar_image, :description

  def avatar_image
    ENV['HOST'] + 'faceless.jpg'
  end
end
