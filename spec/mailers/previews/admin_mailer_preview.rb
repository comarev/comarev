class AdminMailerPreview < ActionMailer::Preview
  def user_self_registration_notification
    admin = FactoryBot.build_stubbed(:user, :admin)
    user = FactoryBot.build_stubbed(:user)

    AdminMailer.user_self_registration_notification(admin_emails: [admin.email], user: user)
  end
end
