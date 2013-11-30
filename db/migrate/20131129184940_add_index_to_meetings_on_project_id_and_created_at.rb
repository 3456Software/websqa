class AddIndexToMeetingsOnProjectIdAndCreatedAt < ActiveRecord::Migration
  def change
    add_index :meetings, [:project_id, :date]
  end
end
