class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.order(:created_at)

    render json: @invoices, status: :ok
  end

  def create
    @invoice = Invoice.create!(invoice_params)

    render json: @invoice, status: :created
  end

  def update
    @invoice = Invoice.find(params[:id])
    @invoice.update!(invoice_params)

    render json: @invoice, status: :ok
  end

  private

  def invoice_params
    params.require(:invoice).permit(:amount, :user_id, :paid, :status)
  end
end
