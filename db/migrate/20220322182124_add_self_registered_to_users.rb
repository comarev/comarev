class AddSelfRegisteredToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :self_registered, :boolean, null: false, default: false
  end
end
