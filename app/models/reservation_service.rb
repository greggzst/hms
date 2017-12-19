class ReservationService < ApplicationRecord
  belongs_to :reservation
  belongs_to :service

  attr_reader :price
end
