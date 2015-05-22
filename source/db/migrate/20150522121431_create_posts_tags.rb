class CreatePostsTags < ActiveRecord::Migration
  def change
    create_table :posts_tags do |t|
      t.belongs_to :posts, null: false
      t.belongs_to :tags, null: false
    end
  end
end
