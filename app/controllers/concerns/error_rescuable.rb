module ErrorRescuable
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
    rescue_from ActionController::ParameterMissing, with: :unprocessable_entity
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    error = I18n.t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default

    render json: { message: error }, status: :unprocessable_entity
  end

  def not_found(exception)
    render json: { message: exception }, status: :not_found
  end

  def unprocessable_entity(exception)
    errors =
      case exception.class.name
      when 'ActiveRecord::RecordInvalid'
        exception.record.errors.full_messages
      else
        { message: exception }
      end

    render json: errors, status: :unprocessable_entity
  end
end
