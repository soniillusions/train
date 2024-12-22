class Main
  require 'date'
  require_relative 'railway_station'
  require_relative 'train'

  attr_accessor :stations
  attr_accessor :current_station

  def initialize
    @stations = []
    @current_station = nil
  end

  def where
    puts "текущая станция: #{self.current_station&.name || 'не задана'}"
    puts "текущий поезд: #{self.current_station&.current_train || 'не найден'}"
    puts "текущий вагон: #{self.current_station&.current_train&.current_car || 'не найден'}"
    puts ''
  end

  def show_stations
    puts 'Список всех станций:'
    self.stations.each_with_index do |station, i|
      puts "#{i} - #{station.name}"
    end
  end

  def create_station
    print "Введите имя для станции: "
    name = gets.chomp
    self.stations << RailwayStation.new(name)

    puts 'Станция успешно создана!'
  end

  def set_station(station)
    @current_station = station
  end

  def choice_station
    if self.stations.empty?
      puts 'Нет ни одной станции'
    else
      puts 'На какую станцию вы хотите перейти?'
      self.stations.each_with_index do |station, i|
        puts "#{i} - #{station.name}"
      end

      print 'Введите с клавиатуры номер станции: '
      n = gets.to_i

      set_station(self.stations[n])

      puts "Теперь вы на станции: #{self.current_station.name}"
    end
  end

  def create_train
    puts 'Какого класса поезд вы хотите создать?'
    puts '1 - грузовой'
    puts '2 - пассажирский'
    print 'Введите с клавиатуры (1 или 2): '
    type = gets.to_i

    if type == 1
      train = CargoTrain.new
      self.current_station.trains << train
    else
      train = PassangerTrain.new
      self.current_station.trains << train
    end
  end

  def send_train
    puts 'Куда вы хотите отправить текущий поезд?'
    self.show_stations

    print 'Введите с клавиатуры номер станции: '
    n = gets.to_i

    self.stations[n].trains << self.current_station.trains.delete(self.current_station.current_train)
  end
end

main = Main.new

puts 'Вас приветствует программа по управлению поездами!'
puts "Сегодня #{Date.today.strftime("%d %B %Y")}"

loop do
  puts 'Что на этот раз? :D'
  puts '1 - Создать станцию'
  puts '2 - Выбрать станцию'
  puts '3 - Создать поезд'
  puts '4 - Выбрать поезд'
  puts '5 - Добавить вагоны к поезду'
  puts '6 - Отцепить вагоны от поезда'
  puts '7 - Показать информацию о поезде'
  puts '8 - Поместить поезд на станцию'
  puts '9 - Показать список всех станций'
  puts '10 - Показать список поездов на текущей станции'
  puts '11 - Указать производителя поезда'
  puts '12 - Показать производителя поезда'
  puts '13 - Выбрать вагон'
  puts '14 - Указать производителя вагона'
  puts '15 - Показать производителя вагона'

  print '=> '
  n = gets.to_i

  puts ''

  case n
  when 0
    break
  when 1
    main.create_station
    puts ''
    main.where
  when 2
    main.choice_station
    puts ''
    main.where
  when 3
    if main.current_station == nil
      puts 'Сначала выберете станцию!'
      main.where
    else
      main.create_train
      puts ''
      main.where
    end
  when 4
    if main.current_station == nil
      puts 'Сначала выберете станцию!'
      main.where
    else
      main.current_station.choice_train
      puts ''
      main.where
    end
  when 5
    if main.current_station == nil || main.current_station.current_train == nil
      puts 'Сначала выберете поезд!'
      main.where
    else
      main.current_station.current_train.add_car
      puts ''
      main.where
    end
  when 6
    if main.current_station == nil || main.current_station.current_train == nil
      puts 'Сначала выберете поезд!'
      main.where
    else
      main.current_station.current_train.remove_car
      puts ''
      main.where
    end
  when 7
    if  main.current_station == nil || main.current_station.current_train == nil
      puts 'Сначала выберете поезд!'
      main.where
    else
      main.current_station.current_train.show
      puts ''
      main.where
    end
  when 8
    if main.current_station == nil || main.current_station.current_train == nil
      puts 'Сначала выберете поезд!'
      main.where
    else
      main.send_train
      puts ''
      main.where
    end
  when 9
    if main.current_station == nil
      puts 'Нет ни одной станции!'
    else
      main.show_stations
      puts ''
      main.where
    end
  when 10
    if main.current_station == nil
      puts 'Сначала выберете станцию!'
      main.where
    else
      main.current_station.show_trains
      puts ''
      main.where
    end
  when 11
    if main.current_station == nil || main.current_station.current_train == nil
      puts 'Сначала выберете поезд!'
      main.where
    else
      puts 'Введите название компании для поезда: '
      name = gets.chomp
      main.current_station.current_train.set_name(name)
      puts ''
      main.where
    end
  when 12
    if main.current_station == nil || main.current_station.current_train == nil
      puts 'Сначала выберете поезд!'
      main.where
    else
      main.current_station.current_train.show_company_name
      puts ''
      main.where
    end
  when 13
    if main.current_station == nil || main.current_station.current_train == nil
      puts 'Сначала выберете поезд!'
      main.where
    else
      main.current_station.current_train.choice_car
      puts ''
      main.where
    end
  when 14
    if main.current_station == nil || main.current_station.current_train == nil || main.current_station.current_train.current_car == nil
      puts 'Сначала выберете вагон!'
      puts ''
      main.where
    else
      puts 'Введите название компании для вагона: '
      name = gets.chomp
      main.current_station.current_train.current_car.set_name(name)
      puts ''
      main.where
    end
  when 15
    if main.current_station == nil || main.current_station.current_train == nil || main.current_station.current_train.current_car == nil
      puts 'Сначала выберете вагон!'
      puts ''
      main.where
    elsif main.current_station.current_train.current_car.company_name == nil
      puts 'У вагона не установлено название компании'
      puts ''
      main.where
    else
      main.current_station.current_train.current_car.show_company_name
      puts ''
      main.where
    end
  else
    puts 'Такого варианта овтета нет! Введите 0 для выхода'
    puts ''
    main.where
  end
end

