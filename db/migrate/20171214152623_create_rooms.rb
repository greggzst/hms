class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :capacity, default: 0
      t.float :price, default: 0.0
      t.integer :room_amount, default: 0

      t.timestamps
    end
  end
end
