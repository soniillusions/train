# frozen_string_literal: true

# это главный класс который управляет программой
class Main
  require 'date'
  require_relative 'railway_station'
  require_relative 'train'
  require_relative 'route'
  require_relative 'instance_counter'
  require_relative 'helper_methods'
  require_relative 'menu'

  include InstanceCounter
  include HelperMethods

  attr_accessor :stations, :routes, :current_station, :current_route

  def initialize
    @stations = []
    @routes = []
    @current_station = nil
    @current_route = nil
  end

  def where
    display_current_station
    display_current_train
    display_current_car
    display_current_route
    puts ''
  end

  def display_current_station
    puts "текущая станция: #{current_station&.name || 'не задана'}"
  end

  def display_current_train
    puts "текущий поезд: #{current_station&.current_train || 'не найден'}"
  end

  def display_current_car
    puts "текущий вагон: #{current_station&.current_train&.current_car || 'не найден'}"
  end

  def display_current_route
    puts "текущий маршрут: #{current_route&.name || 'не найден'}"
  end

  def create_station
    print 'Введите имя для станции: '
    name = gets.chomp
    stations << RailwayStation.new(name)

    puts 'Станция успешно создана!'
  end

  def create_route
    print 'Введите имя для нового маршрута: '
    name = gets.chomp

    route = Route.new(name)
    routes << route
    set_route(route)
  end

  def add_station_to_route
    puts 'Список всех станций:'
    each_show(stations)

    print 'Введите номер станции: '
    input = gets.to_i

    if current_route.stations.include?(stations[input]) || stations[input].nil?
      puts 'Error'
    else
      current_route.add_station(stations[input])
    end
  end

  def station=(station)
    self.current_station = station
  end

  def route=(route)
    self.current_route = route
  end

  def choice_route
    if current_route.nil?
      puts 'Нет ни одного маршрута'
    else
      each_show(routes)

      print 'Введите номер станции: '
      input = gets.to_i
      self.route = routes[input]
    end
  end

  def show_stations
    stations.each_with_index do |station, i|
      puts "#{i} - #{station.name}"
    end
  end

  def choice_station
    if stations.empty?
      puts 'Нет ни одной станции'
    else
      puts 'На какую станцию вы хотите перейти?'
      show_stations

      print 'Введите с клавиатуры номер станции: '
      n = gets.to_i

      self.station = stations[n]

      puts "Теперь вы на станции: #{current_station.name}"
    end
  end

  def send_train
    puts 'Куда вы хотите отправить текущий поезд?'
    each_show(stations)

    print 'Введите с клавиатуры номер станции: '
    n = gets.to_i

    stations[n].trains << current_station.trains.delete(current_station.current_train)
    current_station.current_train.current_car = nil
    current_station.current_train = nil
  end
end

main = Main.new
menu = Menu.new(main)

loop do
  menu.show

  puts ''
  main.where
  puts ''
end
