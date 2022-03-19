class DiscountRequestsController < ApplicationController
  def index
    @company = Company.find(params[:company_id])
    authorize(@company, :discount_requests?)

    @discount_requests = @company.discount_requests.order(created_at: :desc)

    render json: @discount_requests
  end
end
