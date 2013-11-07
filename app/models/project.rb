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

class Project < ActiveRecord::Base
  has_many :requirements, dependent: :destroy

  validates :title, presence: true, length: { maximum: 50 }
end
