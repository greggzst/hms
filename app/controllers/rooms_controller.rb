class RoomsController < ApplicationController
  def index
    @rooms_filter_form = RoomsFilterForm.new(start_date: Date.today, end_date: (Date.today + 1.day), number_of_guests: 2)
    @rooms = @rooms_filter_form.query
    render partial: 'rooms/index'
  end

  def filter
    @rooms_filter_form = RoomsFilterForm.new(rooms_filter_form_params)
    @rooms = @rooms_filter_form.query
    render partial: 'rooms/rooms'
  end

  def pre_book
    @reservation = Reservation.new(reservation_params)
    if params[:new_reservation].present? && params[:new_reservation] == 'true'
      Service.available.each { |s| @reservation.reservation_services.build(service: s) }
      render partial: 'reservations/form/form' and return
    elsif params[:add_service].present? && params[:add_service] == 'true'
      @reservation.build_user
      render partial: 'reservations/form/book_form' and return
    elsif params[:email].present?
      if @user = User.where(email: params[:email], has_account: true).first
        @reservation.user = @user
        render partial: 'reservations/form/user_form', locals: { has_account_in_system: true}
      end
    end
  end

  def book
    @reservation = Reservation.new(reservation_params)

    if current_user
      @reservation.user = current_user
      @reservation.save
      head :ok and return
    end

    unless @reservation.user.present?
      @user = User.find_or_initialize_by(email: user_params[:email]) do |user|
        user.attributes = user_params
      end
    end

    if @user.new_record?
      if @user.save
        @reservation.user = @user
        @reservation.save
        head :ok
      else
        @reservation.user = @user unless @reservation.user.present?
        render partial: 'reservations/form/user_form', locals: { errors: show_create_account_errors? }, status: :not_acceptable
      end
    else
      # if user exists in db
      if @user.has_account
        # he has an account
        @user.attributes = user_params
        unless @user.do_not_login
          # he wants to log in
          if @user.valid_password?(user_params[:password]) && @user.accept_terms
            # password valid
            @reservation.user = @user
            @reservation.save
            sign_in(@user)
            render json: { login: true }
          else
            # password invalid
            @user.errors.add(:password, 'is invalid') unless @user.valid_password?(user_params[:password])
            @user.errors.add(:accept_terms, 'must be accepted') unless @user.accept_terms
            @reservation.user = @user unless @reservation.user.present?
            render partial: 'reservations/form/user_form', locals: { has_account_in_system: true }, status: :not_acceptable
          end
        else
          # he doesn't want to log in
          if @user.accept_terms
            @reservation.user = @user
            @reservation.save
            head :ok
          else
            @user.errors.add(:accept_terms, 'must be accepted') unless @user.accept_terms
            @reservation.user = @user unless @reservation.user.present?
            render partial: 'reservations/form/user_form', locals: { has_account_in_system: true, not_login: true }, status: :not_acceptable
          end
        end
      else
        # he doesn't have an account
        @user.update(user_params) if !@user.has_account && user_params[:has_account]
        @reservation.user = @user
        if @reservation.save
          head :ok
        else
          render partial: 'reservations/form/user_form', locals: { errors: true }, status: :not_acceptable
        end
      end
    end
  end

  private

    def reservation_params
      params.require(:reservation).permit(
        :start_date,
        :end_date,
        :base_amount,
        :amount_to_pay,
        reservation_rooms_attributes: [:id, :room_id, :amount_reserved, :guests, :room_price],
        reservation_services_attributes: [:id, :service_id, :amount]
      )
    end

    def user_params
      params.require(:reservation).require(:user_attributes).permit(
        :id,
        :email,
        :has_account,
        :firstname,
        :lastname,
        :valid_document_number,
        :password,
        :password_confirmation,
        :do_not_login,
        :accept_terms
      )
    end

    def rooms_filter_form_params
      params.require(:rooms_filter_form).permit(
        :start_date,
        :end_date,
        :number_of_guests
      )
    end

    def show_create_account_errors?
      errors_keys = @user.errors.messages.keys
      !(errors_keys.sort == [:email, :accept_terms].sort || errors_keys == [:email])
    end
end