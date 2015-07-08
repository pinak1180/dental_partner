class Api::V1::DentalPartner::Forums::CommentsController < Api::V1::BaseController
  before_filter :authentication_user_with_authentication_token, :set_forum

  def create
    @comment = @forum.comments.allowed.build(comment: params[:comment], title: params[:title])
    @comment.user_id = @current_user.id
    if @comment.save
      @forum.mark_user_follow(@current_user)
      render_json({ result: { messages: 'ok', rstatus: 1, errorcode: '' }, data: { messages: 'Comments Sucessfully created' } }.to_json)
    else
      render_json({ result: { messages: @comment.display_errors, rstatus: 0, errorcode: 404 } }.to_json)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :comment)
  end

  def set_forum
    if params[:id].present?
      @forum = ::Forum.find(params[:id])
    else
      render_json({ result: { messages: 'Please provide forum id', rstatus: 0, errorcode: 404 } }.to_json)
    end
  end
end
