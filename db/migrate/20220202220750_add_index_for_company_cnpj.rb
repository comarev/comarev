class AddIndexForCompanyCnpj < ActiveRecord::Migration[6.0]
  def change
    add_index :companies, :cnpj, unique: true
    add_index :companies, :code, unique: true
  end
end
