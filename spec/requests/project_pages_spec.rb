require 'spec_helper'

describe 'Project pages' do

  subject { page }

  describe 'new project page' do
    let(:admin) { FactoryGirl.create(:admin) }
    before do
      sign_in admin
      visit new_project_path
    end
    it { should have_content('new project') }
    it { should have_title(full_title('New project')) }
  end

  describe 'creating new project' do
    let(:admin) { FactoryGirl.create(:admin) }
    before do
      sign_in admin
      visit new_project_path
    end
    let(:submit) { 'Create project' }

    context 'with invalid information' do
      it 'should not create a project' do
        expect { click_button submit }.not_to change(Project, :count)
      end

      describe 'after submission' do
        before { click_button submit }
        it { should have_title('New project') }
        it { should have_content('error') }
      end
    end

    context 'with valid information' do
      before do
        fill_in 'project_title', with: 'Example Project'
        fill_in 'project_desc',  with: 'An example project managed in WebSQA'
      end
      it 'should create a project' do
        expect { click_button submit }.to change(Project, :count).by(1)
      end

      describe 'after submission' do
        before { click_button submit }
        let(:project) { Project.find_by(title: 'Example Project') }
        it { should have_title(project.title) }
        it { should have_selector('div.alert.alert-success', text: 'Project created') }
      end
    end
  end

  describe 'project page' do
    let(:user) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.create(:project) }
    let!(:req1) { FactoryGirl.create(:requirement, project: project, name: 'Example requirement 1') }
    let!(:req2) { FactoryGirl.create(:requirement, project: project, name: 'Example requirement 2') }
    before do
      sign_in user
      visit project_path(project)
    end
    it { should have_content(project.title) }
    it { should have_title(project.title) }
    it { should_not have_link('Project administration') }
    it { should_not have_button('Add a requirement') }
    it { should have_button('Log a meeting') }
    it { should have_button('Report a bug') }
    it { should_not have_link('Manage users') }

    context 'as an admin user' do
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        sign_in admin
        visit project_path(project)
      end
      it { should have_link('Project administration') }
      it { should have_button('Add a requirement') }
      it { should have_link('Manage users') }
    end

    describe 'requirements' do
      it { should have_content(req1.name) }
      it { should have_content(req2.name) }
    end
  end

  describe 'edit' do
    let(:admin) { FactoryGirl.create(:admin) }
    let(:project) { FactoryGirl.create(:project) }
    before do
      sign_in admin
      visit edit_project_path(project)
    end
    describe 'page' do
      it { should have_content('Project administration') }
      it { should have_title('Edit project') }
    end

    context 'with invalid information' do
      before do
        fill_in 'project_title', with: ' '
        click_button 'Save changes'
      end
      it { should have_content('error') }
    end

    context 'with valid information' do
      let(:new_title) { 'New Title' }
      let(:new_desc) { 'New description' }
      before do
        fill_in 'project_title', with: new_title
        fill_in 'project_desc',  with: new_desc
        click_button 'Save changes'
      end
      it { should have_title(new_title) }
      it { should have_selector('div.alert.alert-success', text: 'updated') }
      specify { expect(project.reload.title).to eq new_title }
      specify { expect(project.reload.desc).to eq new_desc }
    end
  end

  describe 'index' do
    let(:user) { FactoryGirl.create(:user) }
    before(:all) { 30.times { FactoryGirl.create(:project) } }
    after(:all) { Project.delete_all }
    before do
      sign_in user
      visit projects_path
    end
    it { should have_title('Projects') }
    it { should have_content('Projects') }

    describe 'pagination' do
      it { should have_selector('ul.pagination') }
      it 'should list each project' do
        Project.paginate(page: 1, per_page: 10).each do |project|
          expect(page).to have_selector('li', text: project.title)
        end
      end
    end

    describe 'delete links' do
      it { should_not have_link('delete') }

      context 'as an admin user' do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit projects_path
        end
        it { should have_link('delete', href: project_path(Project.first)) }
        it 'should be able to delete a project' do
          expect do
            click_link('delete', match: :first)
          end.to change(Project, :count).by(-1)
        end
      end
    end
  end
end
