class User < ActiveRecord::Base
  has_many :posts, foreign_key: 'author_id'
  has_and_belongs_to :groups, foreign_key: 'owner_id'
end
