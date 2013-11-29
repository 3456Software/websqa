require 'spec_helper'

describe ReportGen do

  let(:project){ FactoryGirl.create(:project) }
  before do
    @report_gen = project.report_gens.build(name: "ExampleReport", description: "A short description")
  end
  subject { @report_gen }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:project_id) }
  it { should respond_to(:status) }
  its(:status) { should be_false }

  it {should respond_to(:project) }
  its(:project) { should eq project }
  it { should be_valid }

  context 'when project_id is not present' do
    before { @report_gen.project_id = nil }
    it { should_not be_valid }
  end

  context 'when name is not present' do
    before { @ report_gen.name = ' ' }
    it { should_not be_valid }
  end

  context 'when name is too long' do
    before { @report_gen.name = 'a' * 141 }
    it { should_not be_valid }
  end



end
