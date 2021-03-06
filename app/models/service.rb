class Service < ApplicationRecord
  has_many :reservation_services, dependent: :nullify
  has_many :reservations, through: :reservation_services

  validates :name, :price, presence: true
  enum availability: [:available, :unavailable]
end
