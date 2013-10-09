require 'spec_helper'

describe 'Static Pages' do

  subject { page }

  shared_examples_for 'all_static_pages' do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe 'Home page' do
    before { visit root_path }
    let(:heading) { 'WebSQA' }
    let(:page_title) { '' }

    it_should_behave_like 'all_static_pages'
    it { should_not have_title(' | Home') }
  end
end
