require_relative 'instance_counter'

class Route
  
  include InstanceCounter
  attr_reader :stations

  def initialize(start, finish)
    validate_stations!(start, finish)
    @stations = [start, finish]
  end

  def validate_stations!(start, finish)
    raise "Начальная станция не задана" if start.nil?
    raise "Конечная станция не задана" if finish.nil?
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def add_station(name_station)
    stations.insert(-2, name_station)
  end

  def delete_station(name_station)
    stations.delete(name_station) if name_station != stations.first && name_station != stations.last
  end

  private

  def validate!
    raise "Начальная станция не задана" if stations.first.nil?
    raise "Конечная станция не задана" if stations.last.nil?
  end

end