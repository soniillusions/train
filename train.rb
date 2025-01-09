module CompanyName
  attr_accessor :company_name

  def set_name(name)
    @company_name = name
  end

  def show_company_name
    puts self.company_name.capitalize
  end
end


class Train
  require_relative 'car'
  require_relative 'instance_counter'
  include CompanyName
  include InstanceCounter

  attr_accessor :cars
  attr_accessor :type
  attr_accessor :speed
  attr_accessor :route
  attr_accessor :current_station
  attr_accessor :current_car
  attr_accessor :number

  NUMBER_FORMAT = /\b[a-z0-9]{3}-?[a-z0-9]{2}\b/i

  @@trains = []

  def initialize(number)
    @@trains << self
    register_instance
    @type = nil
    @cars = []
    @speed = 0
    @route = nil
    @current_station = nil
    @current_car = nil
    @number = number
  end

  def self.find(n)
    puts @@trains[n]
  end

  def set_car(car)
    self.current_car = car
  end

  def choice_car
    if cars.empty?
      puts 'У поезда нет вагонов'
    else
      puts 'Какой вагон вы хотите выбрать?'

      cars.each_with_index do |car, i|
        puts "#{i} - #{car}"
      end

      n = gets.to_i

      set_car(cars[n])

      puts ''
      puts "Теперь вы выбрали вагон: #{current_car}"
    end
  end

  def accelerate(amount)
    self.speed += amount
  end

  def slow_down(amount)
    self.speed -= amount
  end

  def add_car
    raise 'Нельзя добавлять вагон на ходу!' unless speed.zero?

    car = create_car

    raise "Тип вагона #{car.type} не совпадает с типом поезда #{type}" if car.type != type

    cars << car
    puts "#{car.class} успешно добавлен"
  end

  def remove_car
    raise 'Сначала выберете вагон!' if current_car == nil

    cars.delete(current_car)
    puts "#{current_car.class} успешно удален!"
    self.current_car = nil

  rescue RuntimeError => e
    puts e.message
  end

  def show
    puts "id поезда в памяти: #{object_id}"
    puts "тип поезда: #{type}"
    puts "кол-во вагонов: #{cars.size}"
    puts ''
  end

  def add_route(route)
    self.route = route
  end

  def next_station(next_station)
    self.current_station = next_station
  end
end

class PassengerTrain < Train
  def initialize(number)
    super
    @type = 'passenger'
  end

  def validate!
    raise 'Ошибка! Неправильный тип для PassengerTrain' if type != 'passenger'
    raise 'Train number has invalid format!' if number !~ NUMBER_FORMAT
    raise "Train with number #{number} is already exist!" if @@trains.any? {|train| train.number == number}
  end

  def valid?
    validate!
  rescue
    false
  end

  private

  def create_car
    PassengerCar.new
  end
end

class CargoTrain < Train
  def initialize(number)
    super
    @type = 'cargo'
    validate!
  end

  def validate!
    raise 'Ошибка! Неправильный тип для CargoTrain!' if type != 'cargo'
    raise 'Number has invalid format' if number !~ NUMBER_FORMAT
  end

  def valid?
    validate!
  rescue
    false
  end

  private

  def create_car
    CargoCar.new
  end
end
