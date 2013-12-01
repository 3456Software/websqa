require 'spec_helper'

describe 'Meeting pages' do

  subject { page }

  describe 'logging a new meeting' do
    let(:user) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.create(:project) }
    before do
      sign_in user
      project.add_member!(user)
      visit project_path(project)
    end

    context 'with invalid information' do
      it 'should not create a meeting log' do
        expect { click_button 'Log meeting' }.not_to change(Meeting, :count)
      end

      describe 'error messages' do
        before { click_button 'Log meeting' }
        it { should have_content('error') }
      end

      context 'with valid information' do
        before do
          fill_in 'meeting_name',        with: 'Example meeting'
          fill_in 'meeting_date_string', with: 'Today at 4:00'
        end

        it 'should create a meeting' do
          expect { click_button 'Log meeting' }.to change(Meeting, :count).by(1)
        end
      end
    end
  end

  describe 'deleting a meeting' do
    let(:project) { FactoryGirl.create(:project) }
    let!(:meeting) { FactoryGirl.create(:meeting, project: project) }

    context 'as a non-admin user' do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        project.add_member!(user)
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

      it 'should delete a meeting' do
        expect { click_link 'delete' }.to change(Meeting, :count).by(-1)
      end
    end
  end
end
