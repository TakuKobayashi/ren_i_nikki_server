class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer  :user_id, null: false
      t.string   :account_type, null: false
      t.string   :uid, null: false
      t.string   :token
      t.string   :token_secret
      t.datetime :expired_at
      t.timestamps null: false
    end
    add_index :accounts, [:user_id, :account_type], unique: true
    add_index :accounts, :uid
  end
end
