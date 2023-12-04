require_relative 'train'
require_relative 'wagon'
require_relative 'station'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'

station1 = Station.new('Орск')
station2 = Station.new('Оренбург')
station3 = Station.new('Санкт-Петербург')

stations = [station1, station2, station3]


passenger_train = PassengerTrain.new('101')
cargo_train = CargoTrain.new('777')

route = Route.new(station1, station3)
route.add_station(station2)

passenger_train.assign_route(route)

passenger_wagon1 = PassengerWagon.new
passenger_wagon2 = PassengerWagon.new
cargo_wagon1 = CargoWagon.new

passenger_train.add_wagon(passenger_wagon1)
passenger_train.add_wagon(passenger_wagon2)
cargo_train.add_wagon(cargo_wagon1)

puts 'Список станций:'
stations.each do |station|
  puts "Станция #{station.name}"
  puts "Поезда на станции:"
  station.trains.each { |train| puts "Поезд №#{train.number}" }
end
