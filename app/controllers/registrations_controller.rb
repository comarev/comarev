class RegistrationsController < Devise::RegistrationsController
  DEFAULT_REGISTRATION_PARAMS = { active: false, self_registered: true }.freeze
  PERMITTED_PARAMS = %i[email full_name cellphone cpf address].freeze

  before_action :configure_permitted_parameters

  respond_to :json

  private

  def build_resource(params = {})
    super(params.merge(DEFAULT_REGISTRATION_PARAMS))
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: PERMITTED_PARAMS)
  end
end
