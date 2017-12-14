class Room < ApplicationRecord
  has_many :reservation_rooms
  has_many :reservations, through: :reservation_rooms

  validates :name, :capacity, :price, :room_amount, presence: true
end
