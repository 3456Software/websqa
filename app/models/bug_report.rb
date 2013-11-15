# == Schema Information
#
# Table name: bug_reports
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  status      :boolean          default(FALSE)
#  project_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_bug_reports_on_project_id_and_created_at  (project_id,created_at)
#

class BugReport < ActiveRecord::Base

  belongs_to :project
  
  validates :name, presence: true, length: { maximum: 140 }
  validates :project_id, presence: true
end
