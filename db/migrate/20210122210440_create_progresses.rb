class CreateProgresses < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE TYPE progress_type AS ENUM ('tasks', 'experience');
    SQL

    create_table :progresses do |t|
      t.column :track_type, :progress_type, index: true
      t.boolean :auto, default: true, null: false
      t.integer :amount
      t.integer :max
      t.timestamps
    end
  end

  def down
    drop_table :progresses

    execute <<-SQL
      DROP TYPE progress_type;
    SQL
  end
end
