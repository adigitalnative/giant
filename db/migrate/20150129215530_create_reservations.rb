class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :user, null: false
      t.references :item, null: false
      t.references :status, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false

      t.timestamps
    end
    add_index :reservations, :user_id
    add_index :reservations, :item_id
    add_index :reservations, :status_id
  end
end
