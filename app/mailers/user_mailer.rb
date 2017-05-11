class UserMailer < ApplicationMailer

  def verify(user)
    @link = "#{ENV['HOST']}/auth/verify/#{user.uuid}/#{user.verify_token}"
    mail(to: user.email, subject: "Verify your Easy account")
  end

  def invite(from, to, hint)
    @from = from
    @to = to
    @hint = hint
    mail(to: to, subject: "#{@from} has invited you to a secure chat")
  end
end
