class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[show update]

  def index
    authorize(Invoice)
    @invoices = policy_scope(Invoice).order(created_at: :desc)

    render json: @invoices, status: :ok
  end

  def show
    render json: @invoice, status: :ok
  end

  def create
    authorize(Invoice)
    @invoice = Invoice.create!(invoice_params)

    render json: @invoice, status: :created
  end

  def update
    @invoice.update!(invoice_params)

    render json: @invoice, status: :ok
  end

  def check
    authorize(Invoice)
    all_paid = policy_scope(Invoice).all? { |x| x.paid? }
    company = Company.find_by(code: params[:code])

    return render status: :unprocessable_entity if !all_paid
    render json: company, status: :ok
  end

  private

  def set_invoice
    @invoice = authorize Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:amount, :user_id, :paid, :status, :due_date)
  end
end
