module InventoryControl
  
  # 商品の初期化処理
  def self.initilize_product
    cola = Drink.cola
    redbull = Drink.redbull
    water = Drink.water

    return {cola: cola, redbull: redbull, water: water}
  end

  # 在庫の初期化処理
  def self.initilize_replenishment
    cola_inventory = Stock.new(product_name: :cola, number: 5)
    redbull_inventory = Stock.new(product_name: :redbull, number: 1)
    water_inventory = Stock.new(product_name: :water, number: 1)

    return {cola: cola_inventory, redbull: redbull_inventory, water: water_inventory}
  end

  # 商品補充処理
  def self.product_replenishment(product_name: nil, number_of_items: args={}, number: 1)
    stock_of_drinks = number_of_items.find { |k, v| v.product_name.to_sym == product_name }
    stock_of_drinks[1].replenishment(number: number)
  end

  # 商品の一覧確認認処理
  def self.get_product_list(product_list: args={}, number_of_items: args={}, cash_register: nil)
    products = []
    items = []

    product_list.each do |key, product|
      items = number_of_items.find { |k, v| v.product_name.to_sym == product.name.to_sym }

      if cash_register.is_a?(CashRegister)
        if cash_register.total >= product.price && items[1].number > 0
          products << [product.name, product.price, items[1].number]
        end
      else
        if items[1].number > 0
          products << [product.name, product.price, items[1].number]
        end
      end
    end

    return products
  end

  # 対象商品が購入可能か確認処理
  def self.get_product?(product_name: nil, product_list: args={}, number_of_items: 0, cash_register: nil)
    items = product_list.find{ |k, v| v.name.to_sym == product_name.to_sym }
    stock = number_of_items.find { |k, v| v.product_name.to_sym == product_name.to_sym }
    purchase_flg = false

    if cash_register.total >= items[1].price && stock[1].number > 0
      purchase_flg = true
      reason = "available_for_purchase"
    elsif cash_register.total >= items[1].price && stock[1].number == 0
      purchase_flg = false
      reason = "inventory_shortage"
    elsif
      cash_register.total < items[1].price
      purchase_flg = false
      reason = "lack_of_money"
    end

    return { purchase_flg: purchase_flg, reason: reason, item_name: items[1].name }
  end

  # 個別商品の情報確認処理
  def self.product_information(product_name: nil, product_list: nil, number_of_items: nil)
    items = product_list.find{ |k, v| v.name.to_sym == product_name.to_sym }
    stock = number_of_items.find { |k, v| v.product_name.to_sym == product_name.to_sym }
    
    return { product_name: items[1].name, product_price: items[1].price, number_of_items: stock[1] }
  end

end