class AddDateCompletedToBugReports < ActiveRecord::Migration
  def change
    add_column :bug_reports, :date_completed, :datetime
  end
end
