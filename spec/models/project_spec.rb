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
    let!(:older_requirement) {
      FactoryGirl.create(:requirement, project: @project, created_at: 1.day.ago)
    }
    let!(:newer_requirement) {
      FactoryGirl.create(:requirement, project: @project, created_at: 1.hour.ago)
    }

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
end
