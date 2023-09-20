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