class CreateItemTypeAssignments < ActiveRecord::Migration
  def change
    create_table :item_type_assignments do |t|
      t.references :item_type, null: false
      t.references :item, null: false

      t.timestamps
    end
    add_index :item_type_assignments, :item_type_id
    add_index :item_type_assignments, :item_id
  end
end
