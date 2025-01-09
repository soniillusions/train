# этот класс предоставляет Пассажирский поезд
class PassengerTrain < Train
  def initialize(number)
    super
    @type = 'passenger'
    validate!
    @@trains << self
  end

  def validate!
    raise 'Ошибка! Неправильный тип для PassengerTrain' if type != 'passenger'
    raise 'Train number has invalid format!' if number !~ NUMBER_FORMAT
    raise "Train with number #{number} is already exist!" if @@trains.any? { |train| train.number == number }
  end

  def valid?
    validate!
  rescue RuntimeError
    false
  end

  private

  def create_car
    PassengerCar.new
  end
end
