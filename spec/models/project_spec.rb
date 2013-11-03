require 'spec_helper'

describe Project do
  before do
    @project = Project.new(title: 'Example Project',
                           desc:  'An example project managed in WebSQA')
  end

  subject { @project }

  it { should respond_to(:title) }
  it { should respond_to(:desc) }

  it { should be_valid }

  context 'when title is not present' do
    before { @project.title = ' ' }
    it { should_not be_valid }
  end

  context 'when name is too long' do
    before { @project.title = 'a' * 51 }
    it { should_not be_valid }
  end
end
