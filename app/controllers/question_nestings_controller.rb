class QuestionNestingsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question

private

def find_question
  @question = Question.find params[:question_id]
end


end
