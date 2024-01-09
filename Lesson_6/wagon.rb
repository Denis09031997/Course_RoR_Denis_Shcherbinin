require_relative 'company_manufacturer'
require_relative 'validation'

class Wagon
  include CompanyManufacturer
  include Validation
  attr_reader :type

  def initialize(type)
    @type = type
    validate!
  end

  

  private

  def validate!
    validate_presence('Тип вагона', type)
    validate_format('Тип вагона', type, /^(passenger|cargo)$/i)
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

  private

  def validate!
    raise "Тип вагона не задан" if type.nil? || ![:passenger, :cargo].include?(type)
  end
end
