class CreatePostsTags < ActiveRecord::Migration
  def change
    create_table :posts_tags do |t|
      t.belongs_to :post, null: false
      t.belongs_to :tag, null: false
    end
  end
end
