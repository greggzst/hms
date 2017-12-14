class CreateReservationRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :reservation_rooms do |t|
      t.references :reservation, foreign_key: true
      t.references :room, foreign_key: true
      t.integer :amount_reserved, default: 0

      t.timestamps
    end
  end
end
