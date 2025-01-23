# frozen_string_literal: true

require_relative '../car'

RSpec.describe Car do
  describe 'base Car class' do
    let(:car) { Car.new }

    it 'type should be nil' do
      expect(car.type).to be_nil
    end

    it 'should include CompanyName module' do
      expect(Car.included_modules).to include(CompanyName)
    end
  end

  describe CargoCar do
    let(:cargo_car) { CargoCar.new }

    it 'should initialize with cargo type' do
      expect(cargo_car.type).to eq('cargo')
    end

    it 'should inherit from Car' do
      expect(CargoCar.superclass).to eq(Car)
    end
  end

  describe PassengerCar do
    let(:passenger_car) { PassengerCar.new }

    it 'should initialize with passenger type' do
      expect(passenger_car.type).to eq('passenger')
    end

    it 'should inherit from Car' do
      expect(PassengerCar.superclass).to eq(Car)
    end
  end
end
