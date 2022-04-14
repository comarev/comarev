class MonetizeInvoice < ActiveRecord::Migration[6.0]
  def up
    Invoice.update_all "amount = amount * 100"
    change_column :invoices, :amount, :integer
    rename_column :invoices, :amount, :amount_cents
  end

  def down
    Invoice.update_all "amount_cents = amount_cents / 100"
    change_column :invoices, :amount_cents, :float
    rename_column :invoices, :amount_cents, :amount
  end
end
