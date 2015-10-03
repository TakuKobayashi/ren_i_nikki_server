class CreateMissionLocations < ActiveRecord::Migration
  def change
    create_table :mission_locations do |t|
      t.integer :user_id, null: false
      t.integer :mission_id, null: false
      t.float  :lat, null: false, default: 0
      t.float  :lon, null: false, default: 0
      t.timestamps null: false
    end
    add_index :mission_locations, :user_id
    add_index :mission_locations, :mission_id
    add_index :mission_locations, [:lat, :lon]
  end
end
