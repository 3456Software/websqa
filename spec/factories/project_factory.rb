# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  desc       :text
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :project do
    sequence(:title) { |n| "Project #{n}" }
    sequence(:desc)  { |n| "A short description of project #{n}." }
  end
end
