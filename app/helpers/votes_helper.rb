module VotesHelper
  def current_user_vote
    # memoization - first time will make a call to database, 2nd time it will just use instance variable
    @current_user_vote ||= current_user.votes.find_by_question_id @question.id
  end

end
