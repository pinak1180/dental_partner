class Admins::MessagesController < AdminBaseController
  before_action :set_form_details, only: [:new, :edit, :create, :update]
  before_action :set_count, only: [:new, :edit, :index, :show]
  add_breadcrumb 'Messages', :admins_messages_path


  def new
    @message = current_user.sent_messages.build
    @users = User.non_admins.pluck(:email, :id)
    add_breadcrumb 'New Message', new_admins_message_path
  end

  def index
    @messages = current_user.messages.send(params[:q]) rescue current_user.messages.untrashed
    @messages = @messages.parent_messages.includes(:receiver, :sender)
                .order('created_at DESC').page(params[:page]).per(9)
  end

  def create
    @message = current_user.sent_messages.build(message_params)
    if @message.valid? && @message.atleast_one_reciptient?
      msg = @message.create_records ? "Message Sent" : "Your message has not been sent because no users are in your selected target criteria"
      redirect_to admins_messages_path, notice: msg
    else
      @users = User.non_admins.pluck(:email, :id)
      render :new
    end
  end

  def show
    @message = current_user.messages.find(params[:id])
    set_message_read
    @thread = @message.child_messages.includes(:receiver, :sender)
    @reply = current_user.sent_messages.build
  end

  def reply
    @reply = current_user.sent_messages.build(message_params)
    if @reply.save
      redirect_to admins_message_path(@reply.parent.id), notice: 'Message sent'
    else
      @message = @reply.parent
      render :show
    end
  end

  def destroy
    @message = current_user.messages.find(params[:id])
    @message.update(is_deleted: true)
    @message.child_messages.update_all(is_deleted: true)
    redirect_to admins_messages_path, notice: 'Message Deleted'
  end

  def set_message_read
    ids = [@message.id].push(@message.child_messages.ids)
    notifications = PublicActivity::Activity.where(trackable_type: 'Message', trackable_id: ids)
    notifications.update_all(read: true) if notifications.present?
  end

  private

  def message_params
    params.require(:message).permit(:message_body, :send_push, :sender_id, :receiver_id, :parent_id, :msg_attachment, position_ids: [], department_ids: [], practise_code_ids: [],individual_user_ids:[], direct_report_ids: [], access_level_ids: [], direct_user_ids: [])
  end

  def set_count
    @messages_count = current_user.messages.untrashed.parent_messages.count
    @trash_count    = current_user.messages.parent_messages.trash_messages.count
  end
end
