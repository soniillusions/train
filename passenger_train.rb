# frozen_string_literal: true

class PassengerTrain < Train
  validate :type, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    super(number)
    @type = 'passenger'
    validate!
  end

  def validate!
    super
    raise 'Ошибка! Неправильный тип для PassengerTrain' if type != 'passenger'
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
