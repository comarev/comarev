class InvoiceMailer < ApplicationMailer
  default from: 'test@test.com'

  def notify_user_email(user)
    @user = user
    mail(to: @user.email, subject: 'Comarev - Lembrete de expiração de fatura.')
  end
end
