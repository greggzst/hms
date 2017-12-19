class AddGuestsToReservationRoom < ActiveRecord::Migration[5.1]
  def change
    add_column :reservation_rooms, :guests, :integer, default: 0
  end
end
