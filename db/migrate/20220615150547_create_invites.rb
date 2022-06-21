class CreateInvites < ActiveRecord::Migration[6.0]
  def change
    create_table :invites do |t|
      t.references :inviter, null: false, foreign_key: { to_table: :users }
      t.references :company, null: false, foreign_key: true

      t.string :invitation_token, null: false
      t.string :invited_email, null: false
      t.datetime :replied_at
      t.boolean :accepted, :default => nil

      t.timestamps
    end
  end
end
