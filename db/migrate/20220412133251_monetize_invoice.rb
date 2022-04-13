class MonetizeInvoice < ActiveRecord::Migration[6.0]
  def up
    Invoice.update_all "amount = amount * 100"
    change_column :invoices, :amount, :integer
  end

  def down
    Invoice.update_all "amount = amount / 100"
    change_column :invoices, :amount, :float
  end
end
