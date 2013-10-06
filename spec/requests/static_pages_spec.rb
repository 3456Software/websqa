require 'spec_helper'

describe 'Static Pages' do

  describe 'Home page' do

    it "should have the content 'WebSQA'" do
      visit root_path
      expect(page).to have_content('WebSQA')
    end
  end
end
