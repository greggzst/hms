class RoomsFilterForm
  include ActiveModel::Model

  attr_accessor :start_date, :end_date, :number_of_guests
end