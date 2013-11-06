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

require 'spec_helper'

describe Requirement do

  let(:project) { FactoryGirl.create(:project) }
  before { @requirement = project.requirements.build(name: 'Example requirement') }

  subject { @requirement }

  it { should respond_to(:name) }
  it { should respond_to(:date_completed) }
  it { should respond_to(:status) }
  its(:status) { should be_false }
  it { should respond_to(:project_id) }
  it { should respond_to(:project) }
  its(:project) { should eq project }

  it { should be_valid }

  context 'when project_id is not present' do
    before { @requirement.project_id = nil }
    it { should_not be_valid }
  end

  context 'when name is not present' do
    before { @requirement.name = ' ' }
    it { should_not be_valid }
  end

  context 'when name is too long' do
    before { @requirement.name = 'a' * 141 }
    it { should_not be_valid }
  end
end
