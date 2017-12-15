class RoomsController < ApplicationController
  def index
    @rooms_filter_form = RoomsFilterForm.new(start_date: Date.today, end_date: (Date.today + 1.day), number_of_guests: 2)
    @rooms = @rooms_filter_form.query
  end

  def filter

  end
end