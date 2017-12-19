class ReservationRoom < ApplicationRecord
  belongs_to :reservation
  belongs_to :room

  attr_reader :room_price

  def room_price= value
    @room_price = value.to_f
  end
end
