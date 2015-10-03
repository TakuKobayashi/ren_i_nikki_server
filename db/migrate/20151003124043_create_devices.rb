class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.integer :user_id, null: false
      t.integer :category, null: false
      t.string  :notification_token
      t.string  :bluetooth_mac_address
      t.timestamps null: false
    end
    add_index :devices, [:user_id, :category]
    add_index :devices, :bluetooth_mac_address
  end
end
