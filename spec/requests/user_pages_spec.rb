require 'spec_helper'

describe 'User pages' do

  subject { page }

  describe 'signup page' do
    before { visit signup_path }
    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe 'signup' do
    before { visit signup_path }
    let(:submit) { 'Create my account' }

    context 'with invalid information' do
      it 'should not create a user' do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe 'after submission' do
        before { click_button submit }
        it { should have_title('Sign up') }
        it { should have_content('errors') }
      end
    end

    context 'with valid information' do
      before do
        fill_in 'user_name',                  with: 'Example User'
        fill_in 'user_email',                 with: 'user@example.com'
        fill_in 'user_password',              with: 'foobar'
        fill_in 'user_password_confirmation', with: 'foobar'
      end
      it 'should create a user' do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe 'after submission' do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        it { should have_link('Sign out', href: signout_path) }
      end
    end
  end

  describe 'profile page' do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe 'edit' do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }

    describe 'page' do
      it { should have_content('Update your settings') }
      it { should have_title('Edit user') }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    context 'with invalid information' do
      before { click_button 'Save changes' }
      it { should have_content('error') }
    end

    context 'with valid information' do
      let(:new_name) { 'New Name' }
      let(:new_email) { 'new@example.com' }
      before do
        fill_in 'user_name',                  with: new_name
        fill_in 'user_email',                 with: new_email
        fill_in 'user_password',              with: user.password
        fill_in 'user_password_confirmation', with: user.password
        click_button 'Save changes'
      end
      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success', text: 'updated') }
      pending { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
end
