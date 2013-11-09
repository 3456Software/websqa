# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Organization do
  before do
    @organization = Organization.new(name: 'Example Org')
  end

  subject { @organization }

  it { should respond_to(:name) }
end
