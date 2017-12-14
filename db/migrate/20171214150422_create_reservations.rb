class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :is_cancelled, default: false
      t.integer :guests, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
