class AddCascadeDeleteToCompanyUsers < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :company_users, name: "fk_rails_6e70dad67e"
    add_foreign_key :company_users, :companies, on_delete: :cascade
  end
end
