class InvoicesController < ApplicationController
  def index
    authorize(Invoice)
    @invoices = policy_scope(Invoice).order(created_at: :desc)

    render json: @invoices, status: :ok
  end

  def create
    authorize(Invoice)
    @invoice = Invoice.create!(invoice_params)

    render json: @invoice, status: :created
  end

  def update
    authorize(Invoice)
    @invoice = Invoice.find(params[:id])
    @invoice.update!(invoice_params)

    render json: @invoice, status: :ok
  end

  private

  def invoice_params
    params.require(:invoice).permit(:amount, :user_id, :paid, :status)
  end
end
