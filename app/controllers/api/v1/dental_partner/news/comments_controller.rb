class Api::V1::DentalPartner::News::CommentsController < Api::V1::BaseController
  before_filter :authentication_user_with_authentication_token, :set_news

  def create
    @comment = @news.comments.build(comment_params)
    @comment.user_id = @current_user.id
    if @comment.save
      render_json({ result: { messages: 'ok', rstatus: 1, errorcode: '' }, data: { messages: 'Comments Sucessfully created' } }.to_json)
    else
      render_json({ result: { messages: @comment.display_errors, rstatus: 0, errorcode: 404 } }.to_json)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment,:title)
  end

  def set_news
    if params[:id].present?
      @news = ::News.find(params[:id])
    else
      render_json({ result: { messages: 'Please provide news id', rstatus: 0, errorcode: 404 } }.to_json)
    end
  end
end
