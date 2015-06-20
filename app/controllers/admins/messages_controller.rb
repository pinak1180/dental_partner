class Admins::MessagesController < AdminBaseController
  before_action :set_form_details, only: [:new, :edit, :create, :update]

  def new
    @message = current_user.sent_messages.build
  end

  def index
    @messages = current_user.messages.send(params[:q]) rescue current_user.messages.untrashed
    @messages = @messages.parent_messages.includes(:receiver, :sender)
                .order("created_at DESC").page(params[:page]).per(9)
  end

  def create
    @message = current_user.sent_messages.build(message_params)
    if @message.valid? && @message.atleast_one_reciptient?
      @message.create_records
      redirect_to admins_messages_path, notice: "Message sent"
    else
      render :new
    end
  end

  def show
    @message = current_user.messages.find(params[:id])
    @thread = @message.child_messages.includes(:receiver, :sender)
    @reply = current_user.sent_messages.build
  end

  def reply
    @reply = current_user.sent_messages.build(message_params)
    if @reply.save
      redirect_to admins_message_path(@reply.parent.id), notice: "Message sent"
    else
      @message = @reply.parent
      render :show
    end
  end

  def destroy
    @message = current_user.messages.find(params[:id])
    @message.update(is_deleted: true)
    @message.child_messages.update_all(is_deleted: true)
    redirect_to admins_messages_path, notice: "Message Deleted"
  end

  private
  def message_params
    params.require(:message).permit(:message_body, :sender_id, :receiver_id, :parent_id, position_ids: [], department_ids: [], practise_code_ids: [], direct_report_ids: [], access_level_ids: [])
  end
end
