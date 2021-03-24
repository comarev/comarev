class ApplicationController < ActionController::API
  include Pundit
  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  respond_to :json

  def validation_error(resource, status = nil)
    render json: { errors: format_errors(resource.errors) },
           status: status || :bad_request
  end

  def format_errors(errors)
    errors.keys.each_with_object({}) do |k, acc|
      acc[k] = errors.full_messages_for(k)
    end
  end

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    error = I18n.t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    resource = exception.policy.user
    resource.errors.add(:base, error)

    validation_error(resource, :unauthorized)
  end
end
