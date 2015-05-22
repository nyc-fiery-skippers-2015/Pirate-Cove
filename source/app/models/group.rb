class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :posts, dependent: :destroy
  belongs_to :owner, class_name: "User"
end
