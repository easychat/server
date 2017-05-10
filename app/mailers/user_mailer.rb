class UserMailer < ApplicationMailer

  def invite(from, to, hint)
    @from = from
    @to = to
    @hint = hint
    mail(to: to.email, subject: "#{@from.email} wants to start a secure chat")
  end
end
