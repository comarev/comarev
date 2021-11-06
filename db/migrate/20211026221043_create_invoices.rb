class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.references :user, null: false, foreign_key: true
      t.float :amount, null: false
      t.boolean :paid, default: false
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
