class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.references :owner, null: false
      t.timestamps null: false
    end
  end
end
