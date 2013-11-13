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
  has_many :accesses, dependent: :destroy
  has_many :members,  through: :accesses

  validates :title, presence: true, length: { maximum: 50 }

  def member?(user)
    accesses.find_by(member_id: user.id)
  end

  def add_member!(user)
    accesses.create!(member_id: user.id)
  end

  def remove_member!(user)
    accesses.find_by(member_id: user.id).destroy!
  end
end
