class AddAvatarToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :avatar, :string
  end
end
