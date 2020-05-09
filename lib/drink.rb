class Drink
  attr_accessor :name, :price, :number

  def self.cola
    self.new 120, :cola, 5
  end

  def self.redbull
    self.new 200, :redbull, 1
  end

  def self.water
    self.new 100, :water, 1
  end

  def initialize price, name, number
    @name = name
    @price = price
    @number = number
  end

end
