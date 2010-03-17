# == Description
# Holds general user information.
class User < ActiveRecord::Base
  
  has_many :posts
  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email
end