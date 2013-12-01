require 'spec_helper'

describe 'Authentication' do

  subject { page }

  describe 'signin page' do
    before { visit signin_path }
    it { should have_content('Sign in') }
    it { should have_title('Sign in') }

    context 'with invalid information' do
      before { click_button 'Sign in' }
      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-danger', text: 'Invalid') }

      describe 'after visiting another page' do
        before { click_link 'Home' }
        it { should_not have_selector('div.alert.alert-danger') }
      end
    end

    context 'with valid information' do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }
      it { should have_title(user.name) }
      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Settings',    href: edit_user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe 'followed by signout' do
        before { click_link 'Sign out' }
        it { should have_link('Sign in') }
      end
    end
  end

  describe 'authorization' do

    context 'for non-signed-in users' do
      let(:user) { FactoryGirl.create(:user) }

      context 'in the Users controller' do

        describe 'visiting the edit page' do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end

        describe 'submitting to the update action' do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe 'visiting the user index' do
          before { visit users_path }
          it { should have_title('Sign in') }
        end
      end

      context 'in the Projects controller' do
        let(:project) { FactoryGirl.create(:project) }

        describe 'visiting the show page' do
          before { visit project_path(project) }
          it { should have_title('Sign in') }
        end

        describe 'visiting the project index' do
          before { visit projects_path }
          it { should have_title('Sign in') }
        end
      end

      context 'in the Requirements controller' do
        let(:requirement) { FactoryGirl.create(:requirement) }

        describe 'submitting to the update action' do
          before { patch requirement_path(requirement) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end

      describe 'attempting to visit a protected page' do
        before do
          visit edit_user_path(user)
          sign_in user
        end

        context 'after signing in' do
          it 'should render the desired protected page' do
            expect(page).to have_title('Edit user')
          end

          describe 'when signing in again' do
            before do
              delete signout_path
              visit signin_path
              sign_in user
            end
            it 'should render the default (profile) page' do
              expect(page).to have_title(user.name)
            end
          end
        end
      end
    end

    context 'as wrong user' do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: 'wrong@example.com') }
      before { sign_in user, no_capybara: true }

      describe 'submitting a GET request to the Users#edit action' do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe 'submitting a PATCH request to the Users#update action' do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end

    context 'as a non-member of a project' do
      let(:user) { FactoryGirl.create(:user) }
      let(:project) { FactoryGirl.create(:project) }
      let!(:requirement) { FactoryGirl.create(:requirement, project: project) }

      before { sign_in user, no_capybara: true }

      context 'in the Projects controller' do

        describe 'submitting a GET request to the Projects#show action' do
          before { get project_path(project) }
          specify { expect(response).to redirect_to(root_url) }
        end
      end

      context 'in the Requirements controller' do

        describe 'submitting a PATCH request to the Requirements#update action' do
          before { patch requirement_path(requirement) }
          specify { expect(response).to redirect_to(root_url) }
        end
      end

      context 'in the BugReports controller' do
        let!(:bug_report) { FactoryGirl.create(:bug_report, project: project) }

        describe 'submitting a POST request to the BugReports#create action' do
          before { post bug_reports_path, bug_report: { project_id: project.id } }
          specify { expect(response).to redirect_to(root_url) }
        end

        describe 'submitting a PATCH request to the BugReports#update action' do
          before { patch bug_report_path(bug_report) }
          specify { expect(response).to redirect_to(root_url) }
        end
      end

      context 'in the Meetings controller' do

        describe 'submitting a POST request to the Meetings#create action' do
          before { post meetings_path, meeting: { project_id: project.id } }
          specify { expect(response).to redirect_to(root_url) }
        end
      end
    end

    context 'as non-admin user' do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }
      before { sign_in non_admin, no_capybara: true }

      context 'in the Users controller' do

        describe 'submitting a DELETE request to the Users#destroy action' do
          before { delete user_path(user) }
          specify { expect(response).to redirect_to(root_url) }
        end
      end

      context 'in the Projects controller' do
        let(:project) { FactoryGirl.create(:project) }

        describe 'submitting a GET request to the Projects#new action' do
          before { get new_project_path }
          specify { expect(response).to redirect_to(root_url) }
        end

        describe 'submitting a POST request to the Projects#create action' do
          before { post projects_path }
          specify { expect(response).to redirect_to(root_url) }
        end

        describe 'submitting a GET request to the Projects#edit action' do
          before { get edit_project_path(project) }
          specify { expect(response).to redirect_to(root_url) }
        end

        describe 'submitting a PATCH request to the Projects#update action' do
          before { patch project_path(project) }
          specify { expect(response).to redirect_to(root_url) }
        end

        describe 'submitting a DELETE request to the Projects#destroy action' do
          before { delete project_path(project) }
          specify { expect(response).to redirect_to(root_url) }
        end
      end

      context 'in the Requirements controller' do

        describe 'submitting a POST request to the Requirements#create action' do
          before { post requirements_path }
          specify { expect(response).to redirect_to(root_url) }
        end

        describe 'submitting a DELETE request to the Requirements#destroy action' do
          before { delete requirement_path(FactoryGirl.create(:requirement)) }
          specify { expect(response).to redirect_to(root_url) }
        end
      end

      context 'in the BugReports controller' do

        describe 'submitting a DELETE request to the BugReports#destroy action' do
          before { delete bug_report_path(FactoryGirl.create(:bug_report)) }
          specify { expect(response).to redirect_to(root_url) }
        end
      end

      context 'in the Meetings controller' do

        describe 'submitting a DELETE request to the Meetings#destroy action' do
          before { delete meeting_path(FactoryGirl.create(:meeting)) }
          specify { expect(response).to redirect_to(root_url) }
        end
      end

      context 'in the Accesses controller' do

        describe 'submitting a POST request to the Accesses#create action' do
          before { post accesses_path }
          specify { expect(response).to redirect_to(root_url) }
        end

        describe 'submitting a DELETE request to the Accesses#destroy action' do
          before { delete access_path(1) }
          specify { expect(response).to redirect_to(root_url) }
        end
      end
    end
  end
end
