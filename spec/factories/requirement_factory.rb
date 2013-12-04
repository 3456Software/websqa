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
#  description    :text
#
# Indexes
#
#  index_requirements_on_project_id_and_created_at  (project_id,created_at)
#

FactoryGirl.define do
  factory :requirement do
    name 'Example requirement'
    project
  end
end
