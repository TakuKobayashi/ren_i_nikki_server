class CreateMstTvPrograms < ActiveRecord::Migration
  def change
    create_table :mst_tv_programs do |t|
      t.string :ProgID, null: false
      t.datetime :TSStart, null: false
      t.datetime :TSEnd, null: false
      t.datetime :RealTSStart, null: false
      t.datetime :RealTSEnd, null: false
      t.datetime :Date, null: false
      t.integer :Week, null: false
      t.string :ServiceID, null: false
      t.string :GenreID, null: false
      t.string :Title, null: false
      t.integer :Complete, null: false
      t.integer :NumScene, null: false
      t.integer :NumCM, null: false
      t.integer :NumProduct, null: false
      t.integer :NumShop, null: false
      t.datetime :TSUpdate, null: false
    end
  end
end
