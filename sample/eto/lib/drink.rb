class Drink
  attr_accessor :name, :price, :honsu

  def self.cola
    self.new 120, :cola, 5
  end

  def self.redbull
    self.new 200, :redbull, 1
  end

  def self.water
    self.new 100, :water, 1
  end

  def initialize price, name, honsu
    @name = name
    @price = price
    @honsu = honsu
  end

end
