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
  include CompanyName

  attr_accessor :cars
  attr_accessor :type
  attr_accessor :speed
  attr_accessor :route
  attr_accessor :current_station
  attr_accessor :current_car

  def initialize
    @type = nil
    @cars = []
    @speed = 0
    @route = nil
    @current_station = nil
    @current_car = nil
  end

  def set_car(car)
    self.current_car = car
  end

  def choice_car
    if self.cars.empty?
      puts 'У поезда нет вагонов'
    else
      puts 'Какой вагон вы хотите выбрать?'

      self.cars.each_with_index do |car, i|
        puts "#{i} - #{car}"
      end

      n = gets.to_i

      set_car(self.cars[n])

      puts ''
      puts "Теперь вы выбрали вагон: #{self.current_car}"
    end
  end

  def accelerate(amount)
    self.speed += amount
  end

  def slow_down(amount)
    self.speed -= amount
  end

  def add_car
    if self.speed == 0
      self.cars << Car.new
    else
      false
    end
  end

  def remove_car
    if self.speed == 0
      self.cars.delete_at(0)
    else
      false
    end
  end

  def show
    puts "id поезда в памяти: #{self.object_id}"
    puts "тип поезда: #{self.type}"
    puts "кол-во вагонов: #{self.cars.size}"
    puts ''
  end

  def add_route(route)
    self.route = route
  end

  def next_station(next_station)
    self.current_station = next_station
  end
end

class PassangerTrain < Train
  def initialize
    super
    @type = 'passanger'
  end

  def add_car
    if self.speed == 0
      self.cars << PassangerCar.new
      puts 'Пассажирский вагон успешно добавлен!'
    else
      false
    end
  end

  def remove_car
    super
    puts 'Пассажирский вагон успешно удален!'
  end
end

class CargoTrain < Train
  def initialize
    super
    @type = 'cargo'
  end

  def add_car
    if self.speed == 0
      self.cars << CargoCar.new
      puts 'Грузовой вагон успешно добавлен!'
    else
      false
    end
  end

  def remove_car
    super
    puts 'Грузовой вагон успешно удален!'
  end
end
