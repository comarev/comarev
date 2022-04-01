class PasswordsController < Devise::PasswordsController
  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      render json: { message: 'Reset password email was successfully sent' }, status: :ok
    else
      render json: { message: 'Reset password email could not be sent' }, status: :bad_request
    end
  end
end
