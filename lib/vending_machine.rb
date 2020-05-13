require './lib/drink'
require './lib/manual'
require './lib/message'
require './lib/money'
require './lib/cash_register'
require './lib/stock'
require './lib/inventory_control'

class VendingMachine
  include Manual
  include Message
  include Money
  include InventoryControl

  Manual.first_message

  def initialize
    initialize_message
    @cash_register = CashRegister.new(total: 0, 
                              sales: 0, change: 0)
    @products = initialize_product
    @number_of_items = initilize_replenishment
  end

  # 商品の初期化処理
  def initialize_product
    cola = Drink.new(product_name: :cola, product_price: 120)
    redbull = Drink.new(product_name: :redbull, product_price: 200)
    water = Drink.new(product_name: :water, product_price: 100)

    return {cola: cola, redbull: redbull, water: water}
  end
  
  # 在庫の初期化処理
  def initilize_replenishment
    cola_inventory = Stock.new(product_name: :cola, number: 5)
    redbull_inventory = Stock.new(product_name: :redbull, number: 1)
    water_inventory = Stock.new(product_name: :water, number: 1)

    return {cola: cola_inventory, redbull: redbull_inventory, water: water_inventory}
  end

  # 新商品追加処理
  def new_product_addition(product_name, product_price) 
    drink = Drink.new(product_name: product_name, product_price: product_price)
    stock = Stock.new(product_name: drink.name)
    @products[product_name] = drink
    @number_of_items[product_name] = stock
    return { drink_name: drink.name, 
             drink_price: drink.price, 
             number_of_items: stock.number }
  end

  # お金投入処理
  def insert_coin(money)
    if Money::MONEY.include?(money)
      Message.insert_message(money)
      @cash_register.add_total(money)
      Message.current_total_message(total: @cash_register.total)
    else
      Message.insert_error_message(money, @cash_register.total)

      return money
    end
  end

  # 払い戻し処理
  def refund
    @cash_register.refund
    Message.refund_message(@cash_register.change)

    return @cash_register.change
  end

  # 商品補充処理
  def drink_replenishment(drink_name: :cola, number: 1)
    InventoryControl.product_replenishment(product_name: drink_name, number_of_items: @number_of_items, number: number)
    Message.replenishment_message(product_name: drink_name) 

    return drink_name, number
  end

  ## 商品の一覧確認認処理
  def list_of_drinks
    Message.lineup_message
    products = InventoryControl.get_product_list(product_list: @products, 
                                                  number_of_items: @number_of_items)
    Message.lineup_information_message(product_list: products)

    return products
  end

  # 購入可能な商品の一覧確認認処理
  def available_drinks
    Message.available_for_purchase_lineup_message
    products = InventoryControl.get_product_list(product_list: @products, 
                                                 number_of_items: @number_of_items, 
                                                 cash_register: @cash_register)

    return products
  end

  # 対象商品が購入可能か確認処理
  def available?(product_name)
    Message.purchase_confirmation_message(product_name: product_name)
    search_result = {}
    search_result = InventoryControl.get_product?(product_name: product_name,
                                                  product_list: @products,
                                                  number_of_items: @number_of_items,
                                                  cash_register: @cash_register)

    if search_result[:reason] == "available_for_purchase"
      Message.available_for_purchase_message(product_name: search_result[:item_name])
    elsif search_result[:reason] == "inventory_shortage"
      Message.inventory_shortage_message
    elsif search_result[:reason] == "lack_of_money"
      Message.lack_of_money(product_name: search_result[:item_name])
    end

    return search_result[:purchase_flg]
  end

  # 購入処理
  def purchase(product_name)
    product_information = InventoryControl.product_information(product_name: product_name, 
                                                               product_list: @products,
                                                               number_of_items: @number_of_items)

   if @cash_register.total >= product_information[:product_price] && product_information[:number_of_items].number > 0
      Message.purchase_message(product_name: product_name)
      Message.purchased_message(product_name: product_information[:product_name])

      @cash_register.purchase(product_information[:product_price])
      Message.subtraction_process_message(product_price: product_information[:product_price])
      Message.current_total_message(total: @cash_register.total)

      @cash_register.add_sales(product_information[:product_price])
      Message.add_sales_message(product_price: product_information[:product_price])

      product_information[:number_of_items].shipment
      Message.current_stock_number(product_name: product_information[:product_name], 
                                   number_of_items: product_information[:number_of_items].number)

      return [product_information[:product_name],
              product_information[:product_price], 
              product_information[:number_of_items].number]

    elsif @cash_register.total >= product_information[:product_price] && product_information[:number_of_items].number == 0
      Message.not_available_due_to_ack_of_stock_message

    elsif @cash_register.total < product_information[:product_price]
      Message.do_not_have_enough_money_to_purchase(product_name: product_information[:product_name])
    end
  end

  #売上確認処理
  def current_sales
    @cash_register.sales
  end

  #残金確認処理
  def current_total
    @cash_register.total
  end

  #お釣り確認処理
  def current_change
    @cash_register.change
  end

  #個別商品の情報確認処理
  def product_information(product_name: :cola)
    product_information = InventoryControl.product_information(product_name: product_name, 
                                                               product_list: @products,
                                                               number_of_items: @number_of_items)
    return [product_information[:product_name], 
            product_information[:product_price], 
            product_information[:number_of_items].number]
  end
end