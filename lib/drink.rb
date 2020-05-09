class Drink
  # attr_accessor :name, :price, :number
  attr_accessor :name, :price

  def self.cola
    # self.new 120, :cola, 5
    self.new 120, :cola
  end

  def self.redbull
    # self.new 200, :redbull, 1
    self.new 200, :redbull
  end

  def self.water
    # self.new 100, :water, 1
    self.new 100, :water
  end

  # def initialize price, name, number
  #   @name = name
  #   @price = price
  #   @number = number
  # end

  def initialize price, name
    @name = name
    @price = price
  end

end
