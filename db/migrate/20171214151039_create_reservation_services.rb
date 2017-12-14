class CreateReservationServices < ActiveRecord::Migration[5.1]
  def change
    create_table :reservation_services do |t|
      t.references :reservation, foreign_key: true
      t.references :service, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
