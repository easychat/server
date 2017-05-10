class UserMailer < ApplicationMailer

  def invite(from, to, hint)
    @from = from
    @to = to
    @hint = hint
    mail(to: to, subject: "#{@from} has invited you to a secure chat")
  end
end
