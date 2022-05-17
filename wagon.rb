class Wagon
  include CompanyName
  include InstanceCounter
  include Validate

  attr_accessor :type

  TYPE = /^(cargo|passenger)$/i

  def initialize (type)
    @type = type
    validate!
  end

  private

  def validate!
    raise 'Введите "cargo" или "passenger".' if type !~ TYPE
  end

end
