class AddStatusToItems < ActiveRecord::Migration
  def change
    add_column :items, :status, :boolean, default: true
  end
end
