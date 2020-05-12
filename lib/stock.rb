class Stock
  attr_reader :product_name, :number, :stock_number
  
  def initialize(product_name: :cola, number: 1)
    @product_name = product_name
    @number = number
  end

  def replenishment(number: 1)
    @number += number
  end

  def shipment(number: 1)
    @number -= number
  end

end