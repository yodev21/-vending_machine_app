class Stock
  attr_accessor :drink_name, :number, :stock_number
  
  def initialize(drink_name: "cola", number: 0)
    Message.replenishment_message
    @drink_name = drink_name
    @number = number
    @stock_number = {drink_name: @drink_name, number: @number}
  end

  def replenishment
    @number += 1
  end

  def shipment
    @number -= 1
  end

end