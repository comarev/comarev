class AdminMailer < ApplicationMailer
  def user_self_registration_notification(admin_emails:, user:)
    @user = user

    mail(to: admin_emails, subject: default_i18n_subject(name: user.full_name))
  end
end
