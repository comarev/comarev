class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :cnpj, null: false, unique: true
      t.string :address
      t.string :phone
      t.boolean :active, null: false, default: false
      t.string :code
      t.integer :discount

      t.timestamps
    end
  end
end
