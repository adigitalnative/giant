class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.references :user, null: false

      t.timestamps
    end
    add_index :items, :user_id
  end
end
