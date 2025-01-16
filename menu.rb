# frozen_string_literal: true

class Menu
  require 'tty-prompt'

  attr_accessor :main, :prompt, :choices

  def initialize(main)
    @main = main
    @prompt = TTY::Prompt.new
    @choices = [
      { name: 'Выйти', value: 0 },
      { name: 'Создать станцию', value: 1 },
      { name: 'Выбрать станцию', value: 2 },
      { name: 'Создать поезд', value: 3 },
      { name: 'Выбрать поезд', value: 4 },
      { name: 'Добавить вагон к поезду', value: 5 },
      { name: 'Отцепить вагон от поезда', value: 6 },
      { name: 'Показать информацию о поезде', value: 7 },
      { name: 'Поместить поезд на станцию', value: 8 },
      { name: 'Показать список всех станций', value: 9 },
      { name: 'Показать список поездов на текущей станции', value: 10 },
      { name: 'Указать производителя поезда', value: 11 },
      { name: 'Показать производителя поезда', value: 12 },
      { name: 'Выбрать вагон', value: 13 },
      { name: 'Указать производителя вагона', value: 14 },
      { name: 'Показать производителя вагона', value: 15 },
      { name: 'Показать список всех станций', value: 16 }, # Дублируется
      { name: 'Показать поезд по номеру', value: 17 },
      { name: 'Добавить на выбранный маршрут станцию', value: 18 },
      { name: 'Удалить станцию из маршрута', value: 19 },
      { name: 'Показать список всех станций на выбранном маршруте', value: 20 },
      { name: 'Создать маршрут', value: 21 }
    ]
  end

  puts 'Вас приветствует программа по управлению поездами!'
  puts "Сегодня #{Date.today.strftime('%d %B %Y')}"
  puts ''

  def run_action(user_input)
    case user_input
    when 0 then brake
    when 1 then main.create_station
    when 2 then main.choice_station
    when 3 then validate_station { main.current_station.create_train }
    when 4 then validate_station { main.current_station.choice_train }
    when 5 then validate_train { main.current_station.current_train.add_car }
    when 6 then validate_train { main.current_station.current_train.remove_car }
    when 7 then validate_train { main.current_station.current_train.show }
    when 8 then validate_train { main.send_train }
    when 9 then validate_stations { main.show_stations }
    when 10 then validate_station { main.current_station.show_trains }
    when 11 then validate_train { update_train_company }
    when 12 then validate_train { main.current_station.current_train.show_company_name }
    when 13 then validate_train { main.current_station.current_train.choice_car }
    when 14 then validate_car { update_car_company }
    when 15 then validate_car { show_car_company }
    when 16 then RailwayStation.all
    when 17 then validate_train { main.current_station.find_train }
    when 18 then validate_route { main.add_station_to_route }
    when 19 then validate_route { main.current_route.remove_station }
    when 20 then validate_route { main.current_route.show }
    when 21 then main.create_route
    else
      puts 'Такого варианта овтета нет! Введите 0 для выхода'
    end
  end

  def show
    user_input = prompt.select('Что на этот раз? :D', choices, per_page: 21)
    run_action(user_input)
  end

  private

  def validate_station
    if main.current_station.nil?
      puts 'Сначала выберете станцию!'
    else
      yield
    end
  end

  def validate_stations
    if main.stations.empty?
      puts 'Нет ни одной станции!'
    else
      yield
    end
  end

  def validate_train
    if main.current_station.current_train.nil?
      puts 'Сначала выберете поезд!'
    else
      yield
    end
  end

  def update_train_company
    print 'Введите название компании для поезда: '
    name = gets.chomp
    main.current_station.current_train.name = name
  end

  def validate_car
    if main.current_station.current_train.current_car.nil?
      puts 'Сначала выберете вагон!'
    else
      yield
    end
  end

  def update_car_company
    puts 'Введите название компании для вагона: '
    name = gets.chomp
    main.current_station.current_train.current_car.name = name
  end

  def show_car_company
    car = main.current_station.current_train.current_car

    if car.company_name.nil?
      puts 'У вагона не установлено название компании'
    else
      car.show_company_name
    end
  end

  def validate_route
    if main.current_route.nil?
      puts 'Сначала выберете маршрут!'
    else
      yield
    end
  end
end
