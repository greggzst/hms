require 'rails_helper'

RSpec.describe Room, type: :model do
  context 'Validation' do
    before(:each) do
      @room = Room.new
    end

    it 'is valid with valid attributes' do
      @room.name = 'test name'
      @room.description = 'test description'
      @room.capacity = 2
      @room.price = 120
      @room.room_amount = 1
      expect(@room).to be_valid
    end

    it 'is invalid without name' do
      @room.capacity = 2
      @room.price = 120
      @room.room_amount = 1
      expect(@room).to_not be_valid
    end

    it 'is invalid without capacity' do
      @room.name = 'test name'
      @room.capacity = nil
      @room.price = 120
      @room.room_amount = 1
      expect(@room).to_not be_valid
    end

    it 'is invalid without price' do
      @room.name = 'test name'
      @room.capacity = 2
      @room.price = nil
      @room.room_amount = 1
      expect(@room).to_not be_valid
    end

    it 'is invalid without room_amount' do
      @room.name = 'test name'
      @room.capacity = 2
      @room.price = 120
      @room.room_amount = nil
      expect(@room).to_not be_valid
    end

    it 'is invalid without all attributes' do
      expect(@room).to_not be_valid
    end
  end
end
