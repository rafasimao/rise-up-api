class CreateAreas < ActiveRecord::Migration[6.1]
  def up
    create_table :areas do |t|
      t.string :title
      t.references :user, index: true, null: false, foreign_key: true
      t.references :progress, foreign_key: true
      t.references :parent_area, index: true, foreign_key: { to_table: :areas }
      t.timestamps
    end
  end

  def down
    drop_table :areas
  end
end
