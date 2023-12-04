require_relative 'company_manufacturer'

class Wagon
  include CompanyManufacturer
  attr_reader :type

  def initialize(type)
    @type = type
  end
end

class PassengerWagon < Wagon
  def initialize
    super(:passenger)
  end
end

class CargoWagon < Wagon
  def initialize
    super(:cargo)
  end
end
