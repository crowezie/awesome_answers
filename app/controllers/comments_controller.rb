class CommentsController < ApplicationController
  def create
    @comment   = Comment.new comment_params
    @answer = Answer.find params[:answer_id]
    @comment.answer = @answer
    if @comment.save
      answer_anchor = ActionController::Base.helpers.dom_id(@answer)
      redirect_to question_path(@answer.question, anchor: answer_anchor), notice: "comment created!"
    else
      flash[:alert] = "Comment wasn't created"
      # This will render show.html.erb within comments folder (in views)
      # We choose to use render as opposed to redirect_to since otherwise we will loose our errors when the page is refreshed
      render "/comments/show"
    end
  end

  def destroy
    @answer = Answer.find params[:id]
    @comment = Comment.find params[:id]
    @comment.destroy
    redirect_to question_path(@comment.answer), notice: "Comment Deleted."
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

end
