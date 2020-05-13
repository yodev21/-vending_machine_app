class Drink
  attr_reader :name, :price

  def initialize(product_name: :cola, product_price: 120)
    @name = product_name
    @price = product_price
  end
end
