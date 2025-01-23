# frozen_string_literal: true

require_relative '../train'

RSpec.describe Train do
  describe 'base Train class' do
    let(:train) { Train.new('123-45') }

    it 'should initialize with type nil' do
      expect(train.type).to be_nil
    end

    it 'should initialize with number' do
      expect(train.number).to eq('123-45')
    end

    it 'should initialize with cars' do
      expect(train.cars).to be_empty
    end

    it 'should initialize with speed' do
      expect(train.speed).to eq(0)
    end

    it 'should initialize with route' do
      expect(train.route).to be_nil
    end

    it 'should initialize with current station' do
      expect(train.current_station).to be_nil
    end

    it 'should initialize with current car' do
      expect(train.current_car).to be_nil
    end

    it 'should include CompanyName module' do
      expect(Train.included_modules).to include(CompanyName)
    end

    it 'should include InstanceCounter module' do
      expect(Train.included_modules).to include(InstanceCounter)
    end

    it 'should include HelperMethods module' do
      expect(Train.included_modules).to include(HelperMethods)
    end

    it 'should include Validation module' do
      expect(Train.included_modules).to include(Validation)
    end

    it 'should has NUMBER_FORMAT constant' do
      expect(Train.constants).to include(:NUMBER_FORMAT)
    end

    it 'should has @@trains class variable' do
      expect(Train.class_variables).to include(:@@trains)
    end

    it 'should has register_instance method' do
      expect(Train.instance_methods).to include(:register_instance)
    end

    it 'should has car= method' do
      expect(Train.instance_methods).to include(:car=)
    end

    it 'should has choice_car method' do
      expect(Train.instance_methods).to include(:choice_car)
    end

    it 'should has accelerate method' do
      expect(Train.instance_methods).to include(:accelerate)
    end

    it 'should has slow_down method' do
      expect(Train.instance_methods).to include(:slow_down)
    end
  end

  describe 'Train methods' do
    let(:train) { Train.new('123-45') }
    let(:cargo_car) { CargoCar.new }
    let(:passenger_car) { PassengerCar.new }

    describe '#accelerate' do
      it 'should increase speed by given amount' do
        train.accelerate(10)
        expect(train.speed).to eq(10)
      end
    end

    describe '#slow_down' do
      it 'should decrease speed by given amount' do
        train.slow_down(10)
        expect(train.speed).to eq(-10)
      end
    end

    describe '#add_car' do
      it 'raises error when adding car while speed > 0' do
        train.accelerate(10)
        expect { train.add_car }.to raise_error(RuntimeError, 'Нельзя добавлять вагон на ходу!')
      end
    end
  end
end

