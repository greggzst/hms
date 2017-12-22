class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :cancel]

  def index
    redirect_to root_url and return unless user_signed_in?
    @reservations = current_user.reservations
  end

  def show
    render partial: 'reservations/show'
  end

  def cancel
    @reservation.cancel!
    redirect_to reservations_url
  end

  private
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end
end