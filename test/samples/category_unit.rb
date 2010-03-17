require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  context 'a Category instance' do
    should_validate_presence_of :name
    should_validate_uniqueness_of :name
  end
end