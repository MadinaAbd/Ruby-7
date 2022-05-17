require_relative 'company_name'
require_relative 'instance_counter'
require_relative 'validate'
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'

MENU = [
{index: 1, title: "Создать новую стануию", action: :new_station },
{index: 2, title: "Создать новый поезд", action: :new_train },
{index: 3, title: "Задать маршрут", action: :new_route },
{index: 4, title: "Задать маршрут поезду", action: :set_route_train },
{index: 5, title: "Добавить вагон", action: :add_wagon_train },
{index: 6, title: "Удалить вагон", action: :remove_wagon },
{index: 7, title: "Менять станцию", action: :change_station },
{index: 8, title: "Показать станции", action: :view_station_and_trains },
].freeze


def new_station

  puts "Введите название нового класса:"
  class_station_name = gets.chomp.to_sym

  begin
    puts "Введите новую станцию:"
    station_name = gets.chomp.to_sym
    class_station_name = Station.new(station_name)

    puts "Станция #{class_station_name} создана."
  rescue
    puts "Ошибка в названии - неверный формат."
    retry
  end
end

def new_train
  puts "Введите название нового класса:"
  class_train_name = gets.chomp.to_sym

  begin
  puts "Введите номер поезда:"
  train_name = gets.chomp.to_sym

  puts "Введите 1 для создания поезда типа \"passenger\" "
  puts "Введите 2 для создания поезда типа \"cargo\" "
  type_train = gets.chomp.to_i

  case type_train
  when 1
    class_train_name = PassengerTrain.new(train_name)
    puts "Поезд #{class_train_name} создан." if class_train_name.valid?

  when 2
    class_train_name = CargoTrain.new(train_name)
    puts "Поезд #{class_train_name} создан."if class_train_name.valid?

  else
    puts "Ошибка, попробуйте еще раз!"
  end
rescue
  puts "Ошибка, номер поезда не соответствует формату \"...-..\" попробуйте еще раз!"
  retry
end
end

def new_route
  puts "Введите 'new' для создания нового маршрута"
  puts "Введите'manage' для управления станцией на маршруте"
  user_choise = gets.chomp.to_sym

  case user_choise
  when :new
    puts "Введите название нового класса:"
    class_route_name = gets.chomp
    puts "Добавить первую станцию маршрута"
    first_station = gets.chomp.to_sym
    puts "Добавить последнюю станцию маршрута"
    last_station = gets.chomp.to_sym
    class_route_name = Route.new(first_station,last_station)
    puts class_route_name

  when :manage
    puts "Введите 'add' для добавления станции в маршрут"
    puts "Введите 'delete' для удаления станции"
    user_choise = gets.chomp.to_sym

    case user_choise
    when :add
      puts "Введите название класса новой станции на маршруте"
      class_station_name = gets.chomp
      puts "Введите маршрут для добавления станции"
      changed_route = gets.chomp
      changed_route.add_station(class_station_name)

    when :delete
      puts "Введите название класса станции для удаления"
      class_station_name = gets.chomp
      puts "Введите маршрут для удаления станции"
      changed_route = gets.chomp
      changed_route.delete_station(class_station_name)

    else puts "Ошибка"
    end
  end
end

def set_route_train
  puts "Введите название класса маршрута:"
  name_class_train = gets.chomp
  puts "Введите название класса маршрута для поезда"
  route_for_set = gets.chomp
  name_class_train.set_route(route_for_set)
end

def add_wagon_train
  puts "Введите названиe класса поезда для добавления вагонов"
  class_train_name = gets.chomp
  puts "Введите название класса вагона для добавления в поезд"
  class_wagon_name = gets.chomp
  class_train_name.add_wagon(class_wagon_name)
  puts "Ошибка, поезд еще не остановился" unless speed.zero?
  puts "Ошибка типа вагона" unless name_class_train.type_train == class_wagon_name.type
  end

def remove_wagon
  uts "Введите названиe класса поезда для удаления вагоноa"
  class_train_name = gets.chomp
  puts "Введите название класса вагона для удаления"
  class_wagon_name = gets.chomp
  class_train_name.del_wagon(class_wagon_name)
  puts "Ошибка, поезд еще не остановился" unless speed.zero?
  puts "Ошибка типа вагона" unless name_class_train.type_train == class_wagon_name.type
end

def change_station
  puts "Введите 'next' для перехода на следующую станцию".
  puts "Введите 'back' для перехода на предыдущию станцию."
  user_choise = gets.chomp.to_sym

  case user_choise
  when :next
    puts "Введите название класса поезда для перехода на следующую станцию"
    class_train_name = gets.chomp
    class_train_name.move_forward

  when :back
    puts "Введите название класса поезда для перехода на предыдущую станцию"
    class_train_name = gets.chomp
    class_train_name.move_back

  else
    puts "Ошибка"
  end
end

def view_station_and_trains
  puts "Введите название класса маршрута для просмотра списка станций"
  class_route_name = gets.chomp
  class_route_name.way
  puts "Введите название класса станции для просмотра списка поездов на ней"
  class_station_name = gets.chomp
  class_station_name.trains
end

loop do
  puts "Введите свой выбор"
  MENU.each { |item| puts "#{item [:index]}: #{item[:title]}" }
  choice = gets.chomp.to_i
  need_item = MENU.find { |item| item[:index] == choice }
  send(need_item[:action])
  puts "Введите любую клавишу для продолжения или 'exit' для выхода"
  break if gets.chomp.to_sym == :exit
end

