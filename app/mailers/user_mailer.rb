class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Bienvenido a Slach | Acá te explico cómo usarlo')
  end

  def payment_succeeded(payment_intent, sender_rut)
    @payment_intent = payment_intent
    @user = payment_intent.user
    @sender_name = GetNameFromRut.for(rut: sender_rut)
    mail(
      to: @user.email,
      subject: "Te pagaron #{Money.new(@payment_intent.amount, 'CLP').format} por Slach",
      content_type: 'text/html'
    )
  end
end
