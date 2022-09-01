# Preview all emails at http://localhost:3000/rails/mailers/invoce_mailer
class InvoceMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/invoce_mailer/notify_user_email
  def notify_user_email
    InvoceMailer.notify_user_email
  end

end
