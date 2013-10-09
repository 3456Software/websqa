require 'spec_helper'

describe ApplicationHelper do

  describe '#full_title' do

    it 'should include the page title' do
      expect(full_title('foo')).to match(/foo/)
    end

    it 'should include the base title' do
      expect(full_title('foo')).to match(/WebSQA/)
    end

    it 'should form the correct title' do
      expect(full_title('foo')).to eq('WebSQA | foo')
    end

    it 'should not include a bar for the homepage' do
      expect(full_title('')).not_to match(/\|/)
    end
  end
end
