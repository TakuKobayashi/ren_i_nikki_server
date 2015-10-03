class CreateFaceCaptures < ActiveRecord::Migration
  def change
    create_table :face_captures do |t|
      t.integer :user_id, null: false
      t.integer :expression_category, null: false
      t.integer :mst_tv_program_id
      t.timestamps null: false
    end
    add_index :face_captures, [:user_id, :expression_category]
  end
end
