class CreateDiscountRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :discount_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.integer :received_discount, null: false

      t.timestamps
    end
  end
end
