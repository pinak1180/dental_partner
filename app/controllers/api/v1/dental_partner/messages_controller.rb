class Api::V1::DentalPartner::MessagesController < Api::V1::BaseController
  before_filter :authentication_user_with_authentication_token

  def index
    @messages = @current_user.messages.page(@page).per(@limit)
    render json: @messages, each_serializer: MessageSerializer, token: false
  end

  def show
    @message = @current_user.messages.find(params[:id])
    render json: @message, serializer: MessageSerializer, token: true
  end

  def create
    @message = @current_user.sent_messages.build(message_body: params[:message_body], receiver_id: params[:receiver_id], parent_id: params[:parent_id])
    if @message.save
      render_json({ result: { messages: 'ok', rstatus: 1, errorcode: '' }, data: { messages: 'Message Sent Successfully' } }.to_json)
    else
      render_json({ errors: @message.display_errors }.to_json)
    end
  end

  def destroy
    @message = @current_user.messages.where(id: params[:id].split(','))
    @message.update_all(is_deleted: true)
    render_json({ result: { messages: 'ok', rstatus: 1, errorcode: '' }, data: { messages: 'Message Deleted Successfully' } }.to_json)
  end

  def mark_read
    return missing_param if !params[:message_ids].present?
    read = true || params[:read_flag]
    @messages = @current_user.messages.where(id: params[:message_ids].split(','))
    @messages.update_all(is_read: read)
    render_json({ result: { messages: 'ok', rstatus: 1, errorcode: '' }, data: { messages: 'Messages marked Successfully' } }.to_json)
  end

  def missing_param
    render_json({ errors: "Param Message_ids missing" }.to_json)
  end
end
