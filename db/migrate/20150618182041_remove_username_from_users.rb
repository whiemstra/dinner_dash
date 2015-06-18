class RemoveUsernameFromUsers < ActiveRecord::Migration
  def down
    remove_column :users, :username
  end
end
