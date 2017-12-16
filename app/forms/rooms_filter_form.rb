class RoomsFilterForm
  include ActiveModel::Model

  attr_accessor :start_date, :end_date, :number_of_guests

  def query
    reservations_rooms = Reservation.where(
      'date(start_date) < ? AND date(end_date) > ?',
      end_date,
      start_date
      ).includes(
        :reservation_rooms,
        :rooms).map(&:reservation_rooms).flatten.group_by{|rr| [rr.room_id, rr.room]}

    if reservations_rooms.any?
      booked_rooms_ids = reservations_rooms.map do |key, value|
        key[0] if value.count == key[1].room_amount
      end.uniq.join(',')
      Room.where('id NOT IN (?) AND capacity = ?', booked_rooms_ids, number_of_guests)
    else
      Room.where(capacity: number_of_guests)
    end
  end
end