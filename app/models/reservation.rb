class Reservation < ApplicationRecord
  belongs_to :user
  has_many :reservation_services
  has_many :services, through: :reservation_services

  has_many :reservation_rooms
  has_many :rooms, through: :reservation_rooms

  accepts_nested_attributes_for :reservation_rooms, :reservation_services, :user
end
