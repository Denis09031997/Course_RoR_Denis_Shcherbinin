require_relative 'company_manufacturer'

class Wagon
  include CompanyManufacturer
  attr_reader :type

  def initialize(type)
    validate_type!(type)
    @type = type
  end
end

def validate_type!(type)
  raise "Тип вагона не задан" if type.nil? || ![:passenger, :cargo].include?(type)
end

def valid?
  validate!
  true
rescue
  false
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

  private

  def validate!
    raise "Тип вагона не задан" if type.nil? || ![:passenger, :cargo].include?(type)
  end
end
