# == Schema Information
#
# Table name: DefectUpdate
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  desc           :text
#  final          :boolean          default(FALSE)
#  created_at     :datetime
#  updated_at     :datetime
#  project_id     :integer
#
#  Indexes
#
#  index_requirements_on_project_id_and_created_at  (project_id,created_at)
#

class DefectUpdate < ActiveRecord::Base
  default_scope -> { order('created_at ASC') }

  belongs_to :defect
  
  validates :name,      presence: true, length: { maximum: 140 }
  validates :desc,      presence: true
  validates :defect_id, presence: true
end
