class Car
  include CompanyName
  attr_reader :type

  def initialize
    @type = nil
  end
end

class CargoCar < Car
  def initialize
    @type = 'cargo'
  end
end

class PassengerCar < Car
  def initialize
    @type = 'passenger'
  end
end