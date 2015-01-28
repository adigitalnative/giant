class AddArchivedToItems < ActiveRecord::Migration
  def change
    add_column :items, :archived, :boolean, null:false, default: false
  end
end
