class HomeController < ApplicationController
  def index
    @rooms_count = Room.all.map(&:room_amount).sum
  end
end