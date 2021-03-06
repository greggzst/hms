class Reservation < ApplicationRecord
  belongs_to :user
  has_many :reservation_services
  has_many :services, through: :reservation_services

  has_many :reservation_rooms
  has_many :rooms, through: :reservation_rooms

  accepts_nested_attributes_for :reservation_rooms, :reservation_services, :user

  attr_writer :base_amount
  attr_accessor :amount_to_pay

  default_scope { order(created_at: :desc) }

  def base_amount
    count_rooms_costs
  end

  def costs
    rooms_costs = count_rooms_costs
    services_costs = count_services_costs

    rooms_costs + services_costs
  end

  def length_in_days
    (end_date.to_date - start_date.to_date).to_i
  end

  def in_progress?
    Time.now.to_date.between?(start_date.to_date, end_date.to_date)
  end

  def cancel!
    self.is_cancelled = true
    self.save!
  end

  def finished?
    end_date.to_date <= Time.now.to_date || is_cancelled
  end

  private
    def count_rooms_costs
      days = length_in_days
      reservation_rooms.map{|rr| rr.room.price * rr.guests * rr.amount_reserved * days unless rr.room.nil?}.sum
    end

    def count_services_costs
      reservation_services.map{|rs| rs.service.price * rs.amount }.sum
    end
end
