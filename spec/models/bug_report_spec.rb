# == Schema Information
#
# Table name: bug_reports
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  description    :text
#  status         :boolean          default(FALSE)
#  project_id     :integer
#  created_at     :datetime
#  updated_at     :datetime
#  date_completed :datetime
#
# Indexes
#
#  index_bug_reports_on_project_id_and_created_at  (project_id,created_at)
#

require 'spec_helper'

describe BugReport do

  let(:project) { FactoryGirl.create(:project) }
  before do
    @bug = project.bug_reports.build(name: 'Example bug',
                                     description: 'This a short description')
  end

  subject { @bug }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:date_completed) }
  it { should respond_to(:status) }
  its(:status) { should be_false }
  it { should respond_to(:project_id) }
  it { should respond_to(:project) }
  its(:project) { should eq project }

  it { should be_valid }

  context 'when project_id is not present' do
    before { @bug.project_id = nil }
    it { should_not be_valid }
  end

  context 'when name is not present' do
    before { @bug.name = ' ' }
    it { should_not be_valid }
  end

  context 'when name is too long' do
    before { @bug.name = 'a' * 141 }
    it { should_not be_valid }
  end
end
