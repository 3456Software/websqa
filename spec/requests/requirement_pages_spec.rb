require 'spec_helper'

describe "Requirement pages" do

  subject { page }

  let(:admin) { FactoryGirl.create(:admin) }
  let(:project) { FactoryGirl.create(:project) }
  before { sign_in user }
end
