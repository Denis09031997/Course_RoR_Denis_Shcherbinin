require_relative 'instance_counter'
require_relative 'validation'


class Station
  @@all_station = []
  attr_reader :name, :trains

  include InstanceCounter
  include Validation

  validate :name, :presence

  def self.all
    @@all_station
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@all_station << self
  end

  def valid?
    validate!
    true
  rescue
    false
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