class DocumentationsController < ActionController::Base
  layout 'swagger'

  SWAGGER_JSON_PATH = Rails.root.join('config/swagger.json').freeze

  def index; end

  def swagger
    @config = File.read SWAGGER_JSON_PATH

    render json: @config
  end
end
