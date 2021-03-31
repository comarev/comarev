class ApplicationController < ActionController::API
  include Pundit
  include ErrorRescuable

  before_action :authenticate_user!
  respond_to :json
end
