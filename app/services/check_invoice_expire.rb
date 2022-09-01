class CheckInvoiceExpire < ApplicationService
  def call
    invoices.each do |invoice|
      InvoiceMailer.notify_user_email(invoice.user).deliver_later
    end
  end

  private

  def invoices
    @invoices ||= Invoice.in_progress.expires_in_5_days
  end
end
