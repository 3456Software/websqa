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

require 'spec_helper'

describe Project do
  before do
    @project = Project.new(title: 'Example Project',
                           desc:  'An example project managed in WebSQA')
  end

  subject { @project }

  it { should respond_to(:title) }
  it { should respond_to(:desc) }
  it { should respond_to(:requirements) }
  it { should respond_to(:bug_reports) }

  it { should respond_to(:accesses) }
  it { should respond_to(:members) }
  it { should respond_to(:member?) }
  it { should respond_to(:add_member!) }
  it { should respond_to(:remove_member!) }

  it { should be_valid }

  context 'when title is not present' do
    before { @project.title = ' ' }
    it { should_not be_valid }
  end

  context 'when name is too long' do
    before { @project.title = 'a' * 51 }
    it { should_not be_valid }
  end

  describe 'requirement associations' do
    before { @project.save }
    let!(:older_requirement) do
      FactoryGirl.create(:requirement, project: @project, created_at: 1.day.ago)
    end
    let!(:newer_requirement) do
      FactoryGirl.create(:requirement, project: @project, created_at: 1.hour.ago)
    end

    it 'should have the right requirements in the right order' do
      expect(@project.requirements.to_a).to eq [older_requirement, newer_requirement]
    end

    it 'should destroy associated requirements' do
      requirements = @project.requirements.to_a
      @project.destroy
      expect(requirements).not_to be_empty
      requirements.each do |requirement|
        expect(Requirement.where(id: requirement.id)).to be_empty
      end
    end
  end

  describe 'bug_report associations' do
    before { @project.save }
    let!(:older_bug_report) do
      FactoryGirl.create(:bug_report, project: @project, created_at: 1.day.ago)
    end
    let!(:newer_bug_report) do
      FactoryGirl.create(:bug_report, project: @project, created_at: 1.hour.ago)
    end

    it 'should have the right bug reports in the right order' do
      expect(@project.bug_reports.to_a).to eq [older_bug_report, newer_bug_report]
    end

    it 'should destroy associated bug reports' do
      bug_reports = @project.bug_reports.to_a
      @project.destroy
      expect(bug_reports).not_to be_empty
      bug_reports.each do |bug_report|
        expect(BugReport.where(id: bug_report.id))
      end
    end
  end

  describe 'members' do
    let(:user) { FactoryGirl.create(:user) }
    before do
      @project.save
      @project.add_member!(user)
    end

    it { should be_member(user) }
    its(:members) { should include(user) }

    context 'removing member' do
      before { @project.remove_member!(user) }

      it { should_not be_member(user) }
      its(:members) { should_not include(user) }
    end

    describe 'member' do
      subject { user }
      its(:projects) { should include(@project) }
    end
  end
end
