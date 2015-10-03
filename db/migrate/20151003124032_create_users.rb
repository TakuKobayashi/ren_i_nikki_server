class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :token, null: false
      t.integer :using_device_id
      t.datetime :last_login_at, null: false
      t.timestamps null: false
    end
    add_index :users, :using_device_id
    add_index :users, :token, unique: true
  end
end
