class Drink
  attr_reader :name, :price
  
  def self.cola
    self.new 120, 'cola'
  end

  def self.redbull
    self.new 200, 'redbull'
  end

  def self.water
    self.new 100, 'water'
  end

  def initialize price, name
    @price = price 
    @name = name
  end

end