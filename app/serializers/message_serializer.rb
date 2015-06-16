class MessageSerializer < ActiveModel::Serializer
  ## Attributes ##
  attributes :id, :sender_dp, :sender_name, :sender_id,
             :is_new, :sent_date, :is_deleted, :is_read,
             :message_body, :parent_id

  ## Instance Methods ##
  def attributes
    puts serialization_options[:token] == true
    unless serialization_options[:token]
      super.except(:message_body)
    else
      super
    end
  end

  def sender_dp
    ENV['HOST'] + object.sender.avatar.url
  end

  def sender_name
    object.sender.full_name
  end

  def is_new
    !is_read
  end

  def sent_date
    object.created_at
  end
end
