# == Schema Information
#
# Table name: accesses
#
#  id         :integer          not null, primary key
#  project_id :integer
#  member_id  :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_accesses_on_member_id                 (member_id)
#  index_accesses_on_member_id_and_project_id  (member_id,project_id) UNIQUE
#  index_accesses_on_project_id                (project_id)
#

class Access < ActiveRecord::Base
  belongs_to :project, class_name: 'Project'
  belongs_to :member,  class_name: 'User'

  validates :project_id, presence: true
  validates :member_id,  presence: true
end
