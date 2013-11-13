class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses do |t|
      t.integer :project_id
      t.integer :member_id

      t.timestamps
    end
    add_index :accesses, :project_id
    add_index :accesses, :member_id
    add_index :accesses, [:member_id, :project_id], unique: true
  end
end
