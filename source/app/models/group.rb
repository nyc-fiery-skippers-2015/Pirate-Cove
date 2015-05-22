class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :posts
  has_one :owner, class_name: "User"
end
