class CreateBugReports < ActiveRecord::Migration
  def change
    create_table :bug_reports do |t|
      t.string :name
      t.text :description
      t.boolean :status, default: false
      t.integer :project_id

      t.timestamps
    end
    add_index :bug_reports, [:project_id, :created_at]
  end
end
