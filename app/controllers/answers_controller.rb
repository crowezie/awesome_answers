class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @answer   = Answer.new answer_params
    @question = Question.friendly.find params[:question_id]
    @answer.user = current_user
    @answer.question = @question
    respond_to do |format|
      if @answer.save
        AnswersMailer.notify_question_owner(@answer).deliver_later
        format.html { redirect_to question_path(@question), notice: "Answer Created!" }
        format.js { render :create_success }

      else
        flash[:alert] = "Answer wasn't created"
        # This will render show.html.erb within questions folder (in views)
        # We choose to use render as opposed to redirect_to since otherwise we will loose our errors when the page is refreshed
        format.html { render "/questions/show" }
        format.js { render :create_failure }
      end
    end
  end

  def destroy
    @question = Question.friendly.find params[:question_id]
    @answer = Answer.find params[:id]
    @answer.destroy
    respond_to do |format|
      format.html {redirect_to question_path(@question), notice: "Answer Deleted."}
      format.js{render :destroy}
    end
  end

  private
  def answer_params
    params.require(:answer).permit(:body)
  end

end
