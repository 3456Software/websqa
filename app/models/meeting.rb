# == Schema Information
#
# Table name: meetings
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  date        :datetime
#  project_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_meetings_on_project_id_and_created_at  (project_id,created_at)
#  index_meetings_on_project_id_and_date        (project_id,date)
#
class Meeting < ActiveRecord::Base
  default_scope -> { order('date ASC') }

  belongs_to :project

  validates :name,       presence: true, length: { maximum: 140 }
  validates :date,       presence: true
  validates :project_id, presence: true

  def date_string
    date.to_s
  end

  def date_string=(date_string)
    self.date = Chronic.parse(date_string)
  end
end
