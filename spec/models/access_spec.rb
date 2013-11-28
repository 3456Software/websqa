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

require 'spec_helper'

describe Access do
  let(:project) { FactoryGirl.create(:project) }
  let(:member) { FactoryGirl.create(:user) }
  let(:access) { project.accesses.build(member_id: member.id) }

  subject { access }

  it { should be_valid }

  describe 'member methods' do
    it { should respond_to(:member) }
    it { should respond_to(:project) }
    its(:member) { should eq member }
    its(:project) { should eq project }
  end

  describe 'when project id is not present' do
    before { access.project_id = nil }
    it { should_not be_valid }
  end

  describe 'when member id is not present' do
    before { access.member_id = nil }
    it { should_not be_valid }
  end
end
