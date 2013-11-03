require 'spec_helper'

describe 'Project pages' do

  subject { page }

  describe 'new project page' do
    before { visit new_project_path }
    it { should have_content('new project') }
    it { should have_title(full_title('New project')) }
  end

  describe 'creating new project' do
    before { visit new_project_path }
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
    let(:project) { FactoryGirl.create(:project) }
    before { visit project_path(project) }
    it { should have_content(project.title) }
    it { should have_title(project.title) }
  end

  describe 'edit' do
    let(:project) { FactoryGirl.create(:project) }
    before { visit edit_project_path(project) }

    describe ' page' do
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
end
