class Post < ActiveRecord::Base
  validates :title, :presence => true
  validates :body, :presence => true

  has_and_belongs_to_many :tags
  belongs_to :author, class_name: 'User'
end
