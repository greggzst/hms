class Reservation < ApplicationRecord
  belongs_to :user
  has_many :reservation_services
  has_many :services, through: :reservation_services

  has_many :reservation_rooms
  has_many :rooms, through: :reservation_rooms

  accepts_nested_attributes_for :reservation_rooms, :reservation_services, :user

  attr_writer :base_amount
  attr_accessor :amount_to_pay

  def base_amount
    days = length_in_days
    reservation_rooms.map{|rr| rr.room.price * rr.guests * rr.amount_reserved * days}.sum
  end

  def costs
    days = length_in_days
    rooms_costs = reservation_rooms.map{|rr| rr.room.price * rr.guests * rr.amount_reserved * days}.sum
    services_costs = reservation_services.map{|rs| rs.service.price * rs.amount }.sum

    rooms_costs + services_costs
  end

  def length_in_days
    (end_date.to_date - start_date.to_date).to_i
  end
end
