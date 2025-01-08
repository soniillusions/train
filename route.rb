class Route
  attr_accessor :name
  attr_accessor :first_station
  attr_accessor :last_station
  attr_accessor :stations

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

  def show
    stations.each_with_index do |station, i|
      puts "#{i} - #{station.name}"
    end
  end

  def remove_station
    show
    print 'Введите номер станции: '
    input = gets.to_i
    stations.delete_at(input)
  end
end