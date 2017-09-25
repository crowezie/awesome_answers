class CommentsMailer < ApplicationMailer
  def notify_answer_owner(comment)
    @comment = comment
    @answer = comment.answer
    @answer_user = @answer.user
    mail(to: @answer_user.email, subject: "You've got a comment!")
  end
end
