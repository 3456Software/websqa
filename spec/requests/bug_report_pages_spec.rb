require 'spec_helper'

describe 'Bug Report pages' do

  subject { page }

  describe 'reporting new bug' do
    let(:user) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.create(:project) }
    before do
      sign_in user
      visit project_path(project)
    end

    context 'with invalid information' do
      it 'should not create a bug report' do
        expect { click_button 'Report bug' }.not_to change(BugReport, :count)
      end

      describe 'error messages' do
        before { click_button 'Report bug' }
        it { should have_content('error') }
      end

      context 'with valid information' do
        before { fill_in 'bug_report_name', with: 'Example bug' }

        it 'should create a bug report' do
          expect { click_button 'Report bug' }.to change(BugReport, :count).by(1)
        end
      end
    end

    describe 'updating a bug report' do
      let(:user) { FactoryGirl.create(:user) }
      let(:project) { FactoryGirl.create(:project) }
      let!(:bug_report) { FactoryGirl.create(:bug_report, project: project) }
      before do
        sign_in user
        visit project_path(project)
      end

      context 'after clicking "Resolve"' do
        before { click_button 'Resolve' }

        it { should_not have_button 'Resolve' }
        it { should have_content 'Bug resolved' }
        it { should have_content 'Resolved' }
      end
    end

    describe 'deleting a bug report' do
      let(:project) { FactoryGirl.create(:project) }
      let!(:bug_report) { FactoryGirl.create(:bug_report, project: project) }

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

        it 'should delete a bug report' do
          expect { click_link 'delete' }.to change(BugReport, :count).by(-1)
        end
      end
    end
  end
end
