class RemoveGuestsFromReservation < ActiveRecord::Migration[5.1]
  def change
    remove_column :reservations, :guests, :integer
  end
end
