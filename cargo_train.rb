# этот класс предоставляет Грузовой поезд
class CargoTrain < Train
  def initialize(number)
    super
    @type = 'cargo'
    validate!
    @@trains << self
  end

  def validate!
    raise 'Ошибка! Неправильный тип для CargoTrain!' if type != 'cargo'
    raise 'Number has invalid format' if number !~ NUMBER_FORMAT
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