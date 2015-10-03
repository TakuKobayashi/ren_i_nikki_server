class CreateMstMissions < ActiveRecord::Migration
  def change
    create_table :mst_missions do |t|
      t.string :title
      t.string :message
      t.float  :lat, null: false, default: 0
      t.float  :lon, null: false, default: 0
    end
  end
end
