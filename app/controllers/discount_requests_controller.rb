class DiscountRequestsController < ApplicationController
  def index
    authorize(Company, :discount_requests?)

    @company = Company.find(params[:company_id])
    @discount_requests = @company.discount_requests.order(:created_at)

    render json: @discount_requests
  end
end
