require_relative 'instance_counter'

class Route
  
  include InstanceCounter
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