# frozen_string_literal: true

class Car
  include CompanyName
  attr_reader :type

  def initialize
    @type = nil
  end
end

class CargoCar < Car
  def initialize
    super
    @type = 'cargo'
  end
end

class PassengerCar < Car
  def initialize
    super
    @type = 'passenger'
  end
end
