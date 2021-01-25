class CreateProjects < ActiveRecord::Migration[6.1]
  def up
    create_table :projects do |t|
      t.string :title
      t.references :user, index: true, null: false, foreign_key: true
      t.references :progress, foreign_key: true
      t.references :area, index: true, foreign_key: true
      t.references :parent_project, index: true, foreign_key: { to_table: :projects }
      t.timestamps
    end
  end

  def down
    drop_table :projects
  end
end
