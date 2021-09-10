class AddCascadeDeleteToUsers < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :company_users, name: "fk_rails_946619ff40"
    add_foreign_key :company_users, :users, on_delete: :cascade
  end
end
