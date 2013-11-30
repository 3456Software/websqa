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

FactoryGirl.define do
  factory :meeting do
    name 'Example meeting'
    description 'A short description.'
    date DateTime.now
    project
  end
end
