# frozen_string_literal: true

class RailwayStation
  require_relative 'train'
  require_relative 'passenger_train'
  require_relative 'cargo_train'

  attr_reader :name
  attr_accessor :trains, :current_train

  @@instances = 0
  @@stations = []

  def initialize(name)
    @@instances += 1
    @@stations << self
    @name = name
    @trains = []
    @current_train = nil
  end

  def self.all
    puts @@stations
  end

  def find_train
    show_trains

    print 'Введите с клавиатуры номер поезда: '
    n = gets.to_i

    Train.find(n)
  end

  def show_trains
    puts 'Список всех поездов станции:'
    trains.each_with_index do |train, i|
      puts "#{i} - #{train.type}"
    end
  end

  def train=(train)
    self.current_train = train
  end

  def choice_train
    if trains.empty?
      puts 'На станции нет поездов'
    else
      puts 'Какой поезд вы хотите выбрать?'

      trains.each_with_index do |train, i|
        puts "#{i} - #{train.type}"
      end

      print 'Введите с клавиатуры номер поезда: '
      n = gets.to_i

      self.train = trains[n]

      puts ''
      puts "Теперь вы даете команды поезду: #{current_train.type}"
    end
  end

  def create_train
    puts 'Какого класса поезд вы хотите создать?'
    puts '1 - грузовой'
    puts '2 - пассажирский'
    print 'Введите с клавиатуры (1 или 2): '
    type = gets.to_i

    case type
    when 1
      print 'Введите номер поезда (aaa-00): '
      number = gets.to_s

      train = CargoTrain.new(number)
      trains << train
    when 2
      print 'Введите номер поезда (aaa-00): '
      number = gets.to_s

      train = PassengerTrain.new(number)
      trains << train
    else
      raise 'Некорректный ввод! укажите 1 или 2'
    end
  rescue StandardError => e
    puts e.message
  end

  def add_train(train)
    trains << train
    train.current_station = self
  end

  def remove_train(train)
    trains.delete(train)
  end

  def each_train(&block)
    trains.each do |train|
      block&.call(train)
    end
  end
end
