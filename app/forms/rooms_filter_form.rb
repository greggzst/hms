class RoomsFilterForm
  include ActiveModel::Model

  attr_accessor :start_date, :end_date
  attr_reader :number_of_guests

  def number_of_guests= value
    @number_of_guests = value.to_i
  end

  def query
    if start_date != end_date
      reservations_rooms = Reservation.where(
        "is_cancelled = ? AND (date(start_date) < ? AND date(end_date) > ?)",
        false,
        end_date,
        start_date
        ).includes(
          :reservation_rooms,
          :rooms).map(&:reservation_rooms).flatten.group_by{|rr| [rr.room_id, rr.room]}

      if reservations_rooms.any?
        booked_rooms_ids = reservations_rooms.map do |key, value|
          key[0] if key[1] && value.count == key[1].room_amount
        end.uniq.join(',')
        if booked_rooms_ids.length == 0
          Room.where('capacity >= ?', number_of_guests)
        else
          Room.where('id NOT IN (?) AND capacity >= ?', booked_rooms_ids, number_of_guests)
        end
      else
        Room.where('capacity >= ?', number_of_guests)
      end
    else
      []
    end
  end
end