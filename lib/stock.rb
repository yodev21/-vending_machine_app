class Stock
  attr_reader :product_name, :number, :stock_number
  
  def initialize(product_name: "商品名", number: 0)
    @product_name = product_name
    @number = number
  end

  def replenishment(number: 1)
    @number += number
  end

  def shipment
    @number -= 1
  end

end