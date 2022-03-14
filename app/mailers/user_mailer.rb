class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Bienvenido a Slach | Acá te explico cómo usarlo')
  end
end
