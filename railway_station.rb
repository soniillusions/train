class RailwayStation
  attr_reader :name
  attr_accessor :trains
  attr_accessor :current_train

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
    self.trains.each_with_index do |train, i|
      puts "#{i} - #{train.type}"
    end
  end

  def set_train(train)
    self.current_train = train
  end

  def choice_train
    if self.trains.size == 0
      puts 'На станции нет поездов'
    else
      puts 'Какой поезд вы хотите выбрать?'

      self.trains.each_with_index do |train, i|
        puts "#{i} - #{train.type}"
      end

      print 'Введите с клавиатуры номер поезда: '
      n = gets.to_i

      self.current_train = self.trains[n]

      puts ''
      puts "Теперь вы даете команды поезду: #{self.current_train.type}"
    end
  end

  def add_train(train)
    self.trains << train
    train.current_station = self
  end

  def remove_train(train)
    self.trains.delete(train)
  end
end





