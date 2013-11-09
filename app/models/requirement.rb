# == Schema Information
#
# Table name: requirements
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  date_completed :datetime
#  status         :boolean          default(FALSE)
#  created_at     :datetime
#  updated_at     :datetime
#  project_id     :integer
#
# Indexes
#
#  index_requirements_on_project_id_and_created_at  (project_id,created_at)
#

class Requirement < ActiveRecord::Base
  default_scope -> { order('created_at ASC') }

  belongs_to :project

  validates :name,       presence: true, length: { maximum: 140 }
  validates :project_id, presence: true
end
