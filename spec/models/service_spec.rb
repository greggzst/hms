require 'rails_helper'

RSpec.describe Service, type: :model do
  context 'Validation' do
    before(:each) do
      @service = Service.new
    end

    it 'is valid with valid attributes' do
      @service.name = 'test name'
      @service.price = 120
      expect(@service).to be_valid
    end

    it 'is invalid without name' do
      @service.price = 120
      expect(@service).to_not be_valid
    end

    it 'is invalid without price' do
      @service.name = 'test name'
      @service.price = nil
      expect(@service).to_not be_valid
    end

    it 'is invalid without all attributes' do
      expect(@service).to_not be_valid
    end
  end
end
