# == Description
# Comments for posts.
class Comment < ActiveRecord::Base
  belongs_to :post
  
  validates_presence_of :email, :body, :post_id
  
end