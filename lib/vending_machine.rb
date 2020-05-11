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

    @cash_register = CashRegister.new(total: 0, sales: 0, change: 0)

    cola = Drink.cola
    redbull = Drink.redbull
    water = Drink.water

    @drinks = {cola: cola, redbull: redbull, water: water}

    cola_inventory = Stock.new(product_name: :cola, number: 5)
    redbull_inventory = Stock.new(product_name: :redbull, number: 1)
    water_inventory = Stock.new(product_name: :water, number: 1)

    @stock_of_drinks = {cola: cola_inventory, redbull: redbull_inventory, water: water_inventory}

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

  # ドリンク補充
  def drink_replenishment(drink_name: :cola, number: 1)
    InventoryControl.product_replenishment(product_name: drink_name, number_of_items: @stock_of_drinks, number: number)
    Message.replenishment_message(product_name: drink_name) 
    return drink_name, number
  end

  #ラインナップ確認処理
  def list_of_drinks
    Message.lineup_message
    drinks = []
    @drinks.each do |key, drink|
      stock_of_drinks = InventoryControl.stock_number(product_name: drink.name, number_of_items: @stock_of_drinks)
      unless stock_of_drinks[1].number == 0
      Message.lineup_drink_message( drink_name: drink.name, 
                                    drink_price: drink.price, 
                                    drink_number: stock_of_drinks[1].number)
      drinks << [drink.name, drink.price, stock_of_drinks[1].number]
      end
    end
    return drinks
  end

  # 購入可能な商品の一覧確認認処理
  def available_drinks
    Message.available_for_purchase_lineup_message
    drinks = []

    @drinks.each do |key, drink|
      stock_of_drinks = InventoryControl.stock_number(product_name: drink.name, number_of_items: @stock_of_drinks)
      if @cash_register.total >= drink.price && stock_of_drinks[1].number > 0
        Message.lineup_drink_message(drink_name: drink.name, 
                                    drink_price: drink.price, 
                                    drink_number: stock_of_drinks[1].number)
        drinks << [drink.name, drink.price, stock_of_drinks[1].number]
      end

    end
    return drinks
  end

  # 対象商品が購入可能か確認
  def available?(product_name)
    drink = InventoryControl.product_search(product_name: product_name, number_of_items: @drinks)
    stock_of_drinks = InventoryControl.stock_number(product_name: drink[1].name, number_of_items: @stock_of_drinks)

    Message.available_for_purchase_drink_message(drink_name: drink[1].name)

    if @cash_register.total >= drink[1].price && stock_of_drinks[1].number > 0
      Message.available_for_purchase_message(drink_name: drink[1].name)
      return true
    elsif @cash_register.total >= drink[1].price && stock_of_drinks[1].number > 0
      Message.inventory_shortage_message
      return false
    elsif
      @cash_register.total < drink[1].price
      Message.lack_of_money(drink_name: drink[1].name)
      return false
    end
  end

  # 購入処理
  def purchase(product_name)
    drink = InventoryControl.product_search(product_name: product_name, number_of_items: @drinks)
    
    stock_of_drinks = InventoryControl.stock_number(product_name: drink[1].name, number_of_items: @stock_of_drinks)

    Message.purchase_message(drink_name: drink[1].name)

   if @cash_register.total >= drink[1].price && stock_of_drinks[1].number > 0
      Message.purchased_message(drink_name: drink[1].name)

      @cash_register.purchase(drink[1].price)

      Message.subtraction_process_message(drink_price: drink[1].price)
      Message.current_total_message(total: @cash_register.total)

      @cash_register.add_sales(drink[1].price)

      Message.add_sales_message(price: drink[1].price)

      Message.current_stock_number(drink_name: drink[1].name, 
                                   drink_number: stock_of_drinks[1].number)
      stock_of_drinks[1].shipment
      return drink[1].name, drink[1].price, stock_of_drinks[1].number
    elsif @cash_register.total >= drink[1].price && stock_of_drinks[1].number > 0
      Message.not_available_due_to_ack_of_stock_message
    elsif @cash_register.total < drink[1].price
      Message.do_not_have_enough_money_to_purchase(drink_name: drink[1].name)
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
    product = InventoryControl.product_search(product_name: product_name, number_of_items: @drinks)
    stock_number = InventoryControl.stock_number(product_name: product[1].name, number_of_items: @stock_of_drinks)
    return product[1].name, product[1].price, stock_number[1].number
  end
end