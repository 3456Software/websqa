class AddProjectIdColumnToRequirement < ActiveRecord::Migration
  def change
    add_column :requirements, :project_id, :integer
    add_index :requirements, [:project_id, :created_at]
  end
end
