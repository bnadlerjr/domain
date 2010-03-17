require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context 'a User instance' do
    should_validate_presence_of :first_name, :last_name, :email
    should_validate_uniqueness_of :email
  end
end