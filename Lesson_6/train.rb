require_relative 'company_manufacturer'
require_relative 'instance_counter'
require_relative 'validation'

class Train
  # Здесь публичные методы собраны - т.к они нужны непосредственно для управления поездом
  include CompanyManufacturer
  include InstanceCounter
  include Validation
  attr_reader :number, :type, :current_speed, :current_station

  validate :number, :format, /^[a-z0-9]{3}-?[a-z0-9]{2}$/i
  validate :type, :presence

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @current_speed = 0
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def self.find(train_number)
    @@trains.find { |train| train.number == train_number }
  end

  def enlarge_speed(speed)
    self.current_speed += speed
  end

  def stop
    @current_speed = 0
  end

  def assign_route(route)
    @route = route
    @index_station = 0
    current_station.add_train(self)
  end

  def go_next_station
    return unless next_station

    current_station.dispatch(self)
    @index_station += 1
    current_station.add_train(self)
  end

  def go_back_previous_station
    return unless previous_station

    current_station.dispatch(self)
    @index_station -= 1
    current_station.add_train(self)
  end

  def add_wagon(wagon)
    return puts("Во время движения запрещено") if current_speed != 0

    if wagon.type == self.type
      @wagons << wagon
    else
      puts("Неверный тип вагона")
    end
  end

  def remove_wagon(wagon)
    return puts("Во время движения запрещено") if current_speed != 0

    @wagons.delete(wagon)
  end

  protected # Выбираю protected - чтобы к данным методам был доступ у подклассов

  # Вспомогательные методы - отвечают за внутреннюю работу класса и его потомков.

  def validate!
    validate_presence(:number)
    validate_format(:number, /^[a-zA-Z0-9]{3}-?[a-zA-Z0-9]{2}$/)
    validate_presence(:type)
    validate_format(:type, /^(passenger|cargo)$/i)
  end

  def previous_station
    @route.stations[@index_station - 1] if @index_station > 0
  end

  def current_station
    @route.stations[@index_station]
  end

  def next_station
    @route.stations[@index_station + 1] if @index_station < @route.stations.length - 1
  end

  attr_writer :current_speed

end
