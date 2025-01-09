# frozen_string_literal: true

# этот класс описывает Маршрут
class Route
  require_relative 'helper_methods'

  include HelperMethods

  attr_accessor :name, :stations

  def initialize(name)
    @name = name
    @stations = []
  end

  def first_station
    stations.first
  end

  def last_station
    stations.last
  end

  def add_station(station)
    raise ArgumentError, 'Object must be an instance of RailwayStation class' unless station.is_a?(RailwayStation)

    stations << station
  rescue ArgumentError => e
    puts e.message
  end

  def remove_station
    each_show(stations)
    print 'Введите номер станции: '
    input = gets.to_i
    stations.delete_at(input)
  end
end
