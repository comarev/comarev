class ApplicationController < ActionController::API
  before_action :authenticate_user!

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
end
