class AddUserDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :cpf, :string
    add_column :users, :address, :string
    add_column :users, :cellphone, :string
    add_column :users, :admin, :boolean, default: false, null: false
    add_column :users, :active, :boolean, default: true, null: false
  end
end
