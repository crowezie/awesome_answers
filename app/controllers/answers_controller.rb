class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @answer   = Answer.new answer_params
    @question = Question.find params[:question_id]
    @answer.user = current_user
    @answer.question = @question
    if @answer.save
      redirect_to question_path(@question), notice: "Answer Created!"
    else
      flash[:alert] = "Answer wasn't created"
      # This will render show.html.erb within questions folder (in views)
      # We choose to use render as opposed to redirect_to since otherwise we will loose our errors when the page is refreshed
      render "/questions/show"
    end
  end

  def destroy
    @question = Question.find params[:question_id]
    @answer = Answer.find params[:id]
    @answer.destroy
    redirect_to question_path(@question), notice: "Answer Deleted."
  end

  private
  def answer_params
    params.require(:answer).permit(:body)
  end

end
