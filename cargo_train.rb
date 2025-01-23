# frozen_string_literal: true

class CargoTrain < Train
  validate :type, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    super(number)
    @type = 'cargo'
    validate!
  end

  def validate!
    super
    raise 'Ошибка! Неправильный тип для CargoTrain!' if type != 'cargo'
  end

  def valid?
    validate!
  rescue RuntimeError
    false
  end

  private

  def create_car
    CargoCar.new
  end
end
