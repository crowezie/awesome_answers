class VotesController < ApplicationController
  before_action :authenticate_user!, :find_question

def create
  vote = Vote.new vote_params
  vote.user = current_user
  vote.question = @question
  if vote.save
    redirect_to question_path(@question), notice: "Voted!"
  else
    redirect_to question_path(@question), notice: "Can't vote twice!"
  end
end

def update
  vote = Vote.find params[:id]
  if !(can? :update, vote)
    redirect_to root_path, notice: "Access Denied!"
  elsif vote.update vote_params
    redirect_to @question, notice: "Vote Updated"
  else
    redirect_to @question, notice: "Vote was not updated"
  end
  # render json: params
end

def destroy
  vote = Vote.find params[:id]
  if can? :destroy, vote
  vote.destroy
  redirect_to @question, notice: "Vote removed!"
  else
    redirect_to root_path, notice: "Access Denied!"
  end

end

private

def vote_params
  params.require(:vote).permit(:up)
end

def find_question
  @question = Question.friendly.find params[:question_id]
end


# adding the helper method makes this method available in the views

end
