require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  context 'a Comment instance' do
    should_validate_presence_of :email, :body, :post_id
    
  end
end