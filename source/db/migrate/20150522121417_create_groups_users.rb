class CreateGroupsUsers < ActiveRecord::Migration
  def change
    create_table :groups_users do |t|
      t.references :group, null: false
      t.references :user, null: false
      t.timestamps null: false
    end
  end
end
