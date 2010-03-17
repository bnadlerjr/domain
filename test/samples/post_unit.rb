require 'test_helper'

class PostTest < ActiveSupport::TestCase
  context 'a Post instance' do
    should_validate_presence_of :title, :user_id
    should_validate_uniqueness_of :title
  end
end