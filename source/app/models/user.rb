class User < ActiveRecord::Base
  include BCrypt
  has_many :posts, foreign_key: 'author_id'
  has_and_belongs_to_many :groups
  has_many :owned_groups, class_name: 'Group', foreign_key: 'owner_id'


  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(plaintext_password)
    self.password == plaintext_password
  end


end
