class Station

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    trains.push(train)
  end

  def dispatch(name_train)
    trains.delete(name_train)
  end

  def trains_by_type(type)
    trains.select {|train| train.type == type}
  end
end


class Train

  attr_reader :number, :type, :current_speed, :current_station

  def initialize(number, type, quantity_wagons)
    @number = number
    @type = type
    @quantity_wagons = quantity_wagons
    @current_speed = 0
  end

  def enlarge_speed(speed)
    self.current_speed += speed
  end

  def stop
    @current_speed = 0
  end

  def add_wagons
    return puts("Во время движения запрещено") if current_speed != 0
    @quantity_wagons += 1
  end

  def subtract_wagons
    return puts("Во время движения запрещено") if current_speed != 0
    @quantity_wagons -= 1
  end

  def assign_route(route)
    @route = route
    @index_station = 0
    current_station.add_train(self)
  end

  def go_next_station
    return unless next_station

    current_station.dispatch(self)
    @current_station_index += 1
    current_station.add_train(self)
  end

  def go_back_previous_station
    return unless previous_station

    current_station.dispatch(self)
    @current_station_index -= 1
    current_station.add_train(self)
  end

  def previous_station
    @route.stations[@current_station_index - 1] if @current_station_index > 0
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def next_station
    @route.stations[@current_station_index + 1] if @current_station_index < @route.stations.length - 1
  end

end


class Route

  attr_reader :stations

  def initialize(start, finish)
    @stations = [start, finish]
  end

  def add_station(name_station)
    stations.insert(-2, name_station)
  end

  def delete_station(name_station)
    stations.delete(name_station) if name_station != stations.first && name_station != stations.last
  end

end
