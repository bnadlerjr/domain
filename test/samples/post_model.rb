# == Description
# Individual articles created by users.
class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates_presence_of :title, :user_id
  validates_uniqueness_of :title
end