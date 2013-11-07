require 'spec_helper'

describe 'Requirement pages' do

  subject { page }

  describe 'creating new requirement' do
    let(:admin) { FactoryGirl.create(:admin) }
    let(:project) { FactoryGirl.create(:project) }
    before do
      sign_in admin
      visit project_path(project)
    end

    context 'with invalid information' do
      it 'should not create a requirement' do
        expect { click_button 'Save requirement' }.not_to change(Requirement, :count)
      end

      describe 'error messages' do
        before { click_button 'Save requirement' }
        it { should have_content('error') }
      end
    end

    context 'with valid information' do
      before { fill_in 'requirement_name', with: 'Example requirement' }

      it 'should create a requirement' do
        expect { click_button 'Save requirement' }.to change(Requirement, :count).by(1)
      end
    end
  end
end
