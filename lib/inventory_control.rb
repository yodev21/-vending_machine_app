module InventoryControl

  def self.product_replenishment(product_name: :product_name, number_of_items: args={}, number: 1)
    stock_of_drinks = number_of_items.find { |k, v| v.product_name.to_sym == product_name }
    stock_of_drinks[1].replenishment(number: number)
  end

  def self.stock_number(product_name: :product_name, number_of_items: args={})
    number_of_items.find { |k, v| v.product_name.to_sym == product_name.to_sym }
  end

  def self.product_search(product_name: :product_name, number_of_items: args={})
    number_of_items.find{ |k, v| v.name.to_sym == product_name.to_sym }
  end
  
end