class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.integer :user_id, null: false
      t.integer :mst_tv_program_id
      t.integer :mst_misson_id, null: false
      t.string  :grouping_token, null: false
    end
    add_index :missions, [:user_id, :mst_misson_id]
    add_index :missions, :grouping_token
    add_index :missions, :mst_tv_program_id
  end
end
