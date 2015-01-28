class CreateUserAccountTypes < ActiveRecord::Migration
  def change
    create_table :user_account_types do |t|
      t.references :user, null: false
      t.references :account_type, null: false

      t.timestamps
    end
    add_index :user_account_types, :user_id
    add_index :user_account_types, :account_type_id
  end
end
