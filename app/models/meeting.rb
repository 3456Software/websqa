# == Schema Information
#
# Table name: meetings
#
#  id             :integer          not null, primary key
#  desc           :text
#  project_id     :integer
#  created_at      :datetime
#  updated_at      :datetime
#
#  Indexes
#
#  index_requirements_on_project_id_and_created_at  (project_id,created_at)
#
#  note: trial model, mostly copied from other models.  Have not added to project model.
#  please review ~Nik


class Meeting < ActiveRecord::Base
  belongs_to :project
  has_many :members,  through: :accesses
  
  validates :desc, presence: true
  
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