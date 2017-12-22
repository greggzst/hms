module ReservationsHelper
  def date_range_tag(reservation)
    tags = []
    tags << content_tag(:span, class: 'date-from') do
      concat(content_tag(:b, 'Date from:', class: 'mr-3'))
      concat(reservation.start_date.strftime('%d/%m/%Y'))
    end

    tags << content_tag(:span, class: 'date-to ml-5') do
      concat(content_tag(:b, 'Date to:', class: 'mr-3'))
      concat(reservation.end_date.strftime('%d/%m/%Y'))
    end

    tags << content_tag(:span, class: 'length ml-5') do
      concat(content_tag(:b, 'Length:', class: 'mr-3'))
      concat(t('nights', count: reservation.length_in_days))
    end

    content_tag :div, class: 'date-range ml-2 mb-4' do
      tags.join.html_safe
    end
  end

  def rooms_list_tag(reservation, no_amount_and_price = false)
    rooms_list_items = reservation.reservation_rooms.map{|rr| [rr.room.name, rr.amount_reserved, rr.room_price ]}.map do |room|
      room_amount_and_price = "x #{room[1]} - #{number_to_currency(room[2])}"
      content_tag(:li, "#{room[0]} #{room_amount_and_price unless no_amount_and_price}")
    end.join.html_safe

    rooms_list = content_tag(:ul, class: 'rooms-list') do
      concat(rooms_list_items)
    end

    content_tag :div, class: 'rooms ml-2 mb-4' do
      concat(content_tag(:b, "Rooms you're booking:"))
      concat(rooms_list)
    end
  end

  def guests_number_tag(reservation)
    guests_number = reservation.reservation_rooms.map{|rr| rr.guests}.sum

    content_tag :div, class: 'guests-number ml-2 mb-4' do
      concat(content_tag(:b, 'Number of guests:', class: 'mr-3'))
      concat(guests_number)
    end
  end

  def booked_services_tag(reservation)
    booked_services = @reservation.reservation_services.reject{|rs| rs.amount.zero?}

    if booked_services.any?
      booked_services_list_items = booked_services.map{|rs| [rs.service.name, rs.amount, rs.service.price]}.map do |s|
        content_tag(:li, "#{s[0]} x #{s[1]} - #{number_to_currency(s[2])}")
      end.join.html_safe

      booked_services_list = content_tag(:ul, class: 'services-list') do
        concat(booked_services_list_items)
      end

      content_tag :div, class: 'services ml-2 mb-4' do
        concat(content_tag(:b, "Services you're booking:"))
        concat(booked_services_list)
      end
    end
  end
end