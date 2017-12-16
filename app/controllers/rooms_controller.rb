class RoomsController < ApplicationController
  def index
    @rooms_filter_form = RoomsFilterForm.new(start_date: Date.today, end_date: (Date.today + 1.day), number_of_guests: 2)
    @rooms = @rooms_filter_form.query
  end

  def filter

  end

  def pre_book
    if params[:new_reservation].present? && params[:new_reservation] == 'true'
      @reservation = Reservation.new(reservation_params)
      Service.available.each { |s| @reservation.reservation_services.build(service: s) }
      render partial: 'reservations/form' and return
    elsif params[:add_service].present? && params[:add_service] == 'true'
      @reservation = Reservation.new(reservation_params)
      @user = User.new
      render partial: 'reservations/book_form' and return
    end
  end

  def book
    @reservation.user = @user
    if @reservation.save
    else
    end
  end

  private

    def reservation_params
      params.require(:reservation).permit(
        :start_date,
        :end_date,
        :guests,
        reservation_rooms_attributes: [:id, :room_id, :amount_reserved],
        reservation_services_attributes: [:id, :service_id, :amount]
      )
    end
end