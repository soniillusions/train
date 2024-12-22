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

class PassangerCar < Car
  def initialize
    @type = 'passanger'
  end
end