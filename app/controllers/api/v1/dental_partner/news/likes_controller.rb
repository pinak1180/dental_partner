class Api::V1::DentalPartner::News::LikesController < Api::V1::BaseController
  before_filter :authentication_user_with_authentication_token, :set_news

  def create
    @like = @news.liked_by @current_user
    if @like
      render_json({ result: { messages: 'ok', rstatus: 1, errorcode: '' }, data: { messages: 'Sucessfully liked' } }.to_json)
    else
      render_json({ result: { messages: "something went wrong", rstatus: 0, errorcode: 404 } }.to_json)
    end
  end

  def destroy
    @like = @news.downvote_from @current_user
    if @like
      render_json({ result: { messages: 'ok', rstatus: 1, errorcode: '' }, data: { messages: 'Sucessfully disliked' } }.to_json)
    else
      render_json({ result: { messages: "something went wrong", rstatus: 0, errorcode: 404 } }.to_json)
    end
  end

  private
  def set_news
    if params[:id].present?
      @news = ::News.find(params[:id])
    else
      render_json({ result: { messages: 'Please provide news id', rstatus: 0, errorcode: 404 } }.to_json)
    end
  end
end
