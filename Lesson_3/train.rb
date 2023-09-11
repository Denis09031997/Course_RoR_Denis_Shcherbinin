class Station

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains.push(train)
  end

  def return_all_trains
    return @trains
  end

  def dispatch(name_train)
    @trains.delete(name_train)
  end

  def trains_by_type(type)
    @trains.select {|train| train.type == type}
  end
end


class Train

  attr_reader :number, :type, :current_speed, :current_station

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @current_speed = 0
  end

  def enlarge_speed(speed)
    @current_speed += speed
  end

  def current_speed
    return @speed
  end

  def stop
    @current_speed = 0
  end

  def quantity_wagons
    return @wagons
  end

  def add_wagons
    if current_speed == 0
      @wagons += 1
    else
      puts "Во время движения запрещено"
    end
  end

  def subtract_wagons
    if current_speed == 0
      @wagons -= 1
    else
      puts "Во время движения запрещено"
    end
  end

  def assign_route(route)
    @route = route
    @index_station = 0
    current_station.add_train(self)
  end

  def forward_station
    if next_station
      current_station.dispatch(self)
      @current_station_index += 1
      current_station.add_train(self)
    end
  end

  def backward_station
    if previous_station
      current_station.dispatch(self)
      @current_station_index -= 1
      current_station.add_train(self)
    end
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
    @stations.insert(-2, name_station)
  end

  def delete_station(name_station)
    @stations.delete(name_station) if name_station != @stations.first && name_station != @stations.last 
  end

end
