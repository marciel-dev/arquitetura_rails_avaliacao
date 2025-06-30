class UserMailer < ApplicationMailer
  default from: "no-reply@mba.on.rails"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Bem-vindo!")
  end
end
