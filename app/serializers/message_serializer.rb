class MessageSerializer < ActiveModel::Serializer
  ## Attributes ##
  attributes :id, :sender_dp, :sender_name, :sender_id,
             :is_new, :sent_date, :is_deleted, :is_read,
             :message_body, :parent_id, :msg_attachment_url

  ## Instance Methods ##


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
    object.created_at.strftime("%d-%m-%Y")
  end
end
