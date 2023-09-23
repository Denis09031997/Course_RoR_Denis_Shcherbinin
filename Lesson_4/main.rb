require_relative 'train'
require_relative 'wagon'
require_relative 'station'
require_relative 'route'
require_relative 'PassengerTrain'
require_relative 'CargoTrain'

class Main
  ACTIONS = [
    { id: '1', title: 'Создать станцию', action: :create_station },
    { id: '2', title: 'Создать поезд', action: :create_train },
    { id: '3', title: 'Создать маршрут и управлять станциями', action: :create_route },
    { id: '4', title: 'Назначить маршрут поезду', action: :assign_route_to_train },
    { id: '5', title: 'Добавить вагоны', action: :add_wagon_to_train },
    { id: '6', title: 'Отцепить вагоны', action: :remove_wagon_from_train },
    { id: '7', title: 'Переместить поезд по маршруту вперед и назад', action: :move_train_forward },
    { id: '8', title: 'Просмотр  станций и  поездов на станции', action: :list_stations_and_trains },
    { id: '9', title: 'Завершить', action: :exit }
  ]

  def initialize
    @trains = []
    @stations = []
    @routes = []
    @wagons = []
  end

  def start
    loop do
      show_menu
      choice = gets_choice
      call_action(choice)
      break if choice == '9'
    end
  end

  def show_menu
    puts 'Меню:'
    ACTIONS.each { |action| puts "#{action[:id]}. #{action[:title]}" }
  end

  def gets_choice
    print 'Выберите действие: '
    gets.chomp
  end

  def call_action(choice)
    action = ACTIONS.find { |item| item[:id] == choice }
    send(action[:action]) if action
  end

  def create_station
    print 'Введите название станции: '
    name = gets.chomp
    @stations << Station.new(name)
    puts "Станция '#{name}' создана."
  end

  def create_train
    print 'Введите номер поезда: '
    number = gets.chomp
    print 'Выберите тип поезда (1 - Пассажирский, 2 - Грузовой): '
    type_choice = gets.chomp.to_i
    type = (type_choice == 1) ? :passenger : :cargo

    if type_choice != 1 && type_choice != 2
      puts 'Неверный выбор типа.'
      return
    end

    train = (type == :passenger) ? PassengerTrain.new(number) : CargoTrain.new(number)
    @trains << train
    puts "Поезд '#{number}' (#{type}) создан."
  end

  def create_route
    if @stations.length < 2
      puts 'Для создания маршрута нужно как минимум 2 станции.'
      return
    end

    puts 'Список станций:'
    @stations.each_with_index { |station, index| puts "#{index + 1}. #{station.name}" }

    print 'Введите номер начальной станции: '
    start_index = gets.chomp.to_i - 1
    print 'Введите номер конечной станции: '
    finish_index = gets.chomp.to_i - 1

    if start_index < 0 || start_index >= @stations.length || finish_index < 0 || finish_index >= @stations.length
      puts 'Неверные номера станций.'
      return
    end

    start_station = @stations[start_index]
    finish_station = @stations[finish_index]
    @routes << Route.new(start_station, finish_station)
    puts "Маршрут от '#{start_station.name}' до '#{finish_station.name}' создан."
  end

  def assign_route_to_train
    if @trains.empty? || @routes.empty?
      puts 'Нет доступных поездов или маршрутов.'
      return
    end

    puts 'Список поездов:'
    @trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number}" }

    print 'Введите номер поезда: '
    train_index = gets.chomp.to_i - 1

    if train_index < 0 || train_index >= @trains.length
      puts 'Неверный номер поезда.'
      return
    end

    train = @trains[train_index]

    puts 'Список маршрутов:'
    @routes.each_with_index { |route, index| puts "#{index + 1}. #{route.stations.first.name} - #{route.stations.last.name}" }

    print 'Введите номер маршрута: '
    route_index = gets.chomp.to_i - 1

    if route_index < 0 || route_index >= @routes.length
      puts 'Неверный номер маршрута.'
      return
    end

    route = @routes[route_index]
    train.assign_route(route)
    puts "Маршрут назначен поезду '#{train.number}'."
  end

  def add_wagon_to_train
    if @trains.empty? || @wagons.empty?
      puts 'Нет доступных поездов или вагонов.'
      return
    end

    puts 'Список поездов:'
    @trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number}" }

    print 'Введите номер поезда: '
    train_index = gets.chomp.to_i - 1

    if train_index < 0 || train_index >= @trains.length
      puts 'Неверный номер поезда.'
      return
    end

    train = @trains[train_index]

    puts 'Список вагонов:'
    @wagons.each_with_index { |wagon, index| puts "#{index + 1}. #{wagon.type}" }

    print 'Введите номер вагона: '
    wagon_index = gets.chomp.to_i - 1

    if wagon_index < 0 || wagon_index >= @wagons.length
      puts 'Неверный номер вагона.'
      return
    end

    wagon = @wagons[wagon_index]
    train.add_wagon(wagon)
    puts "Вагон прицеплен к поезду '#{train.number}'."
  end

  def remove_wagon_from_train
    if @trains.empty?
      puts 'Нет доступных поездов.'
      return
    end

    puts 'Список поездов:'
    @trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number}" }

    print 'Введите номер поезда: '
    train_index = gets.chomp.to_i - 1

    if train_index < 0 || train_index >= @trains.length
      puts 'Неверный номер поезда.'
      return
    end

    train = @trains[train_index]

    if train.wagons.empty?
      puts 'У поезда нет вагонов для отцепления.'
      return
    end

    puts 'Список вагонов у поезда:'
    train.wagons.each_with_index { |wagon, index| puts "#{index + 1}. #{wagon.type}" }

    print 'Введите номер вагона: '
    wagon_index = gets.chomp.to_i - 1

    if wagon_index < 0 || wagon_index >= train.wagons.length
      puts 'Неверный номер вагона.'
      return
    end

    wagon = train.wagons[wagon_index]
    train.remove_wagon(wagon)
    puts "Вагон отцеплен от поезда '#{train.number}'."
  end

  def move_train_forward
    if @trains.empty?
      puts 'Нет доступных поездов.'
      return
    end

    puts 'Список поездов:'
    @trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number}" }

    print 'Введите номер поезда: '
    train_index = gets.chomp.to_i - 1

    if train_index < 0 || train_index >= @trains.length
      puts 'Неверный номер поезда.'
      return
    end

    train = @trains[train_index]
    train.go_next_station
    puts "Поезд '#{train.number}' перемещен на следующую станцию."
  end

  def move_train_backward
    if @trains.empty?
      puts 'Нет доступных поездов.'
      return
    end

    puts 'Список поездов:'
    @trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number}" }

    print 'Введите номер поезда: '
    train_index = gets.chomp.to_i - 1

    if train_index < 0 || train_index >= @trains.length
      puts 'Неверный номер поезда.'
      return
    end

    train = @trains[train_index]
    train.go_back_previous_station
    puts "Поезд '#{train.number}' перемещен на предыдущую станцию."
  end

  def list_stations_and_trains
    if @stations.empty?
      puts 'Нет доступных станций.'
      return
    end

    puts 'Список станций:'
    @stations.each { |station| puts "Станция #{station.name}" }

    puts 'Введите номер станции: '
    station_index = gets.chomp.to_i - 1

    if station_index < 0 || station_index >= @stations.length
      puts 'Неверный номер станции.'
      return
    end

    station = @stations[station_index]

    puts "Поезда на станции #{station.name}:"
    station.trains.each { |train| puts "Поезд №#{train.number}, тип: #{train.type}, количество вагонов: #{train.wagons.size}" }
  end

  def exit
    puts 'Выход из программы.'
  end
end

Main.new.start