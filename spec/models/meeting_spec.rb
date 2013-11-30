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

require 'spec_helper'

describe Meeting do

  let(:project) { FactoryGirl.create(:project) }
  before do
    @meeting = project.meetings.build(name: 'Example meeting',
                                      description: 'A short description.',
                                      date: DateTime.new(2013, 11, 23, 17, 0, 0, -5))
  end

  subject { @meeting }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:date) }
  it { should respond_to(:date_string) }
  its(:date_string) { should eq '2013-11-23 12:00:00 -0500' }
  it { should respond_to(:project_id) }
  it { should respond_to(:project) }
  its(:project) { should eq project }

  it { should be_valid }

  context 'when project_id is not present' do
    before { @meeting.project_id = nil }
    it { should_not be_valid }
  end

  context 'when name is not present' do
    before { @meeting.name = ' ' }
    it { should_not be_valid }
  end

  context 'when name is too long' do
    before { @meeting.name = 'a' * 141 }
    it { should_not be_valid }
  end

  context 'when date is not present' do
    before { @meeting.date = nil }
    it { should_not be_valid }
  end

  context '#date_string' do
    pending 'could use more tests of input values, but time zones are wonky.'
  end
end
