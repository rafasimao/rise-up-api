class CreateTasks < ActiveRecord::Migration[6.1]
  def up
    create_table :tasks do |t|
      t.text :title
      t.boolean :done, default: false, null: false
      t.datetime :done_at

      t.integer :value_points
      t.integer :difficulty_points
      t.integer :experience_points

      t.references :user, index: true, null: false, foreign_key: true
      t.references :area, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :tasks
  end
end
