# frozen_string_literal: true

# этот класс описывает Вагон
class Car
  include CompanyName
  attr_reader :type

  def initialize
    @type = nil
  end
end

# этот класс описывает Грузовой вагон
class CargoCar < Car
  def initialize
    super
    @type = 'cargo'
  end
end

# этот класс описывает Пассажирский вагон
class PassengerCar < Car
  def initialize
    super
    @type = 'passenger'
  end
end
