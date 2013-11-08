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

  describe 'updating a requirement' do
    let(:user) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.create(:project) }
    let!(:requirement) { FactoryGirl.create(:requirement, project: project) }
    before do
      sign_in user
      visit project_path(project)
    end

    context 'after clicking "Complete' do
      before { click_button 'Complete' }

      it { should_not have_button 'Complete' }
      it { should have_content 'Requirement met' }
      it { should have_content 'Completed' }
    end
  end

  describe 'deleting a requirement' do
    let(:project) { FactoryGirl.create(:project) }
    let!(:requirement) { FactoryGirl.create(:requirement, project: project) }

    context 'as a non-admin user' do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit project_path(project)
      end

      it { should_not have_link 'delete' }
    end

    context 'as an admin' do
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        sign_in admin
        visit project_path(project)
      end

      it 'should delete a requirement' do
        expect { click_link 'delete' }.to change(Requirement, :count).by(-1)
      end
    end
  end
end
