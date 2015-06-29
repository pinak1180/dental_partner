class Admins::CommentsController < ApplicationController
  before_action :set_params

  def create
    @comment = @commentable.comments.build(comment_params)
    if params[:comment][:comment].present? && @comment.save
      redirect_to :back, notice: "Commented successfully"
    else
      redirect_to :back, alert: (params[:comment][:comment].present? ? @comment.errors.full_messages : @comment.errors.full_messages << 'comment cannot be blank')
    end
  end

  private
  def set_params
    if params[:comment][:commentable_type].present? && params[:comment][:commentable_id].present?
      @commentable = params[:comment][:commentable_type].constantize.unscoped.find(params[:comment][:commentable_id])
    else
      redirect_to :back, alert: "Comment resource not found"
    end
  end

  def comment_params
    params.require(:comment).permit(:title, :commentable_id, :commentable_type, :comment, :user_id)
  end
end
