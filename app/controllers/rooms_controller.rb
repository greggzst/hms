class RoomsController < ApplicationController
  def index
    @rooms_filter_form = RoomsFilterForm.new(start_date: Date.today, end_date: (Date.today + 1.day), number_of_guests: 2)
    @rooms = @rooms_filter_form.query
  end

  def filter
    @rooms_filter_form = RoomsFilterForm.new(rooms_filter_form_params)
    @rooms = @rooms_filter_form.query
    render partial: 'rooms/rooms'
  end

  def pre_book
    if params[:new_reservation].present? && params[:new_reservation] == 'true'
      @reservation = Reservation.new(reservation_params)
      Service.available.each { |s| @reservation.reservation_services.build(service: s) }
      render partial: 'reservations/form' and return
    elsif params[:add_service].present? && params[:add_service] == 'true'
      @reservation = Reservation.new(reservation_params)
      @reservation.build_user
      render partial: 'reservations/book_form' and return
    end
  end

  def book
    @reservation = Reservation.new(reservation_params)
    @user = User.find_or_initialize_by(email: user_params[:email]) do |user|
      user.attributes = user_params
    end

    if @user.new_record?
      if @user.save
        @reservation.user = @user
        @reservation.save
      else
        @reservation.build_user unless @reservation.user.present?
        render partial: 'reservations/book_form', status: :not_acceptable
      end
    else
      @reservation.user = @user
      @reservation.save
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

    def user_params
      params.require(:reservation).require(:user_attributes).permit(
        :email,
        :has_account,
        :firstname,
        :lastname,
        :valid_document_number,
        :password,
        :password_confirmation
      )
    end

    def rooms_filter_form_params
      params.require(:rooms_filter_form).permit(
        :start_date,
        :end_date,
        :number_of_guests
      )
    end
end