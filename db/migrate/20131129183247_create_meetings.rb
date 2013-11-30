class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :name
      t.text :description
      t.datetime :date
      t.integer :project_id

      t.timestamps
    end
    add_index :meetings, [:project_id, :created_at]
  end
end
