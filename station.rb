class Station
  include InstanceCounter
  include Validate

  attr_accessor :trains, :name
  @@stations = 0


  def initialize (name)
    @name = name
    @trains = []
    @@stations =+ 1
    validate!
  end

  def self.all
    @@stations
  end


  def add_train (train)
  @trains << train
  puts "Прибыл поезд #{train}"
  end

  def train_type (type)
    @trains.select { |train| train.type == type }
  end

  def send (train)
    @trains.delete(train)
    puts "Отбыл поезд #{train}"

  end

  def train
    @trains.each { |name| print "#{name},"}
  end

private

  def validate!
    raise "Ошибка!!! В названии станции меньше трех букв." if name.to_s.length < 3
  end

end
