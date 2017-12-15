class RoomsController < ApplicationController
  def index
    @rooms_filter_form = RoomsFilterForm.new(start_date: Date.today, end_date: (Date.today + 1.day), number_of_guests: 2)
    @rooms = @rooms_filter_form.query
  end

  def filter

  end

  def pre_book
    @reservation = Reservation.new(reservation_params)
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
        reservation_rooms_attributes: [:room_id, :amount_reserved]
      )
    end

    def set_user
      @user = User.find_or_create_by(email: params[:email]) do |user|
        user.attributes = params[:user_attributes]
      end
    end
end