class AddAllowedToDiscountRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :discount_requests, :allowed, :boolean, null: false, default: false
  end
end
