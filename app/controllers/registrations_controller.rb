class RegistrationsController < Devise::RegistrationsController
  DEFAULT_REGISTRATION_PARAMS = { active: false, self_registered: true }.freeze
  PERMITTED_PARAMS = %i[email full_name cellphone cpf address].freeze

  before_action :configure_permitted_parameters
  after_action :send_user_self_registration_notification_email, only: %i[create] # rubocop:disable Rails/LexicallyScopedActionFilter

  respond_to :json

  private

  def build_resource(params = {})
    super(params.merge(DEFAULT_REGISTRATION_PARAMS))
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: PERMITTED_PARAMS)
  end

  def send_user_self_registration_notification_email
    return unless resource.persisted?

    AdminMailer.user_self_registration_notification(
      admin_emails: User.admins.pluck(:email),
      user: resource
    ).deliver_later
  end
end
