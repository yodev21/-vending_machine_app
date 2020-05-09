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

    @regi = CashRegister.new(total: 0, sales: 0, change: 0)

    @cola = Drink.cola
    @redbull = Drink.redbull
    @water = Drink.water

    @drinks = {cola: @cola, redbull: @redbull, water: @water}

    @cola_inventory = Stock.new(product_name: "cola", number: 5)
    @redbull_inventory = Stock.new(product_name: "redbull", number: 1)
    @water_inventory = Stock.new(product_name: "water", number: 1)

    @stock_of_drinks = {cola: @cola_inventory, redbull: @redbull_inventory, water: @water_inventory}

  end

  #お金投入
  def in(money)
    if Money::MONEY.include?(money)
      Message.insert_message(money)
      @regi.add_total(money)
      Message.current_total_message(total: @regi.total)
    else
      Message.insert_error_message(money, @regi.total)
      return money
    end
  end

  #払い戻し
  def return
    @regi.refund
    Message.refund_message(@regi.change)
    return @regi.change
  end

  # ドリンク補充
  def drink_replenishment(drink_name: "cola", number: 1)
    InventoryControl.product_replenishment(product_name: drink_name, number_of_items: @stock_of_drinks, number: number)
    Message.replenishment_message(drink_name: drink_name) 
  end

  #ラインナップ確認
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

  #ドリンクの在庫確認
  def drinks_available_for_purchase
    Message.available_for_purchase_lineup_message
    drinks = []

    @drinks.each do |key, drink|
      stock_of_drinks = InventoryControl.stock_number(product_name: drink.name, number_of_items: @stock_of_drinks)
      if @regi.total >= drink.price && stock_of_drinks[1].number > 0
        Message.lineup_drink_message(drink_name: drink.name, 
                                    drink_price: drink.price, 
                                    drink_number: stock_of_drinks[1].number)
        drinks << [drink.name, drink.price, stock_of_drinks[1].number]
      end

    end
    drinks
  end

  # 対象ドリンクが購入可能か確認
  def do_you_change_this_drink?(drink_name)
    drink = InventoryControl.product_search(product_name: drink_name, number_of_items: @drinks)
    stock_of_drinks = InventoryControl.stock_number(product_name: drink[1].name, number_of_items: @stock_of_drinks)

    Message.available_for_purchase_drink_message(drink_name: drink[1].name)

    if @regi.total >= drink[1].price && stock_of_drinks[1].number > 0
      Message.available_for_purchase_message(drink_name: drink[1].name)
      return true
    elsif @regi.total >= drink[1].price && stock_of_drinks[1].number > 0
      Message.inventory_shortage_message
      return false
    elsif
      @regi.total < drink[1].price
      Message.lack_of_money(drink_name: drink[1].name)
      return false
    end
  end

  # ドリンク購入処理
  def buy_a_drink(drink_name)
    drink = InventoryControl.product_search(product_name: drink_name, number_of_items: @drinks)
    
    stock_of_drinks = InventoryControl.stock_number(product_name: drink[1].name, number_of_items: @stock_of_drinks)

    Message.buy_a_drink_message(drink_name: drink[1].name)

    if @regi.total >= drink[1].price && stock_of_drinks[1].number > 0
      Message.purchased_a_drink_message(drink_name: drink[1].name)

      @regi.buy(drink[1].price)

      Message.subtraction_process_message(drink_price: drink[1].price)
      Message.current_total_message(total: @regi.total)

      @regi.add_sales(drink[1].price)

      Message.add_sales_message(price: drink[1].price)

      Message.current_stock_number(drink_name: drink[1].name, 
                                   drink_number: stock_of_drinks[1].number)
      @cola_inventory.shipment
      return drink[1].name, drink[1].price, stock_of_drinks[1].number
    elsif @regi.total >= drink[1].price && @cola_inventory.number > 0
      Message.not_available_due_to_ack_of_stock_message
      return false
    elsif @regi.total < drink[1].price
      Message.do_not_have_enough_money_to_buy(drink_name: drink[1].name)
      return false
    end
  end

  #売上確認
  def current_sales
    @regi.sales
  end

  #残金確認
  def current_total
    @regi.total
  end

  #お釣り確認
  def current_change
    @regi.change
  end

  #個別商品の情報を確認
  def product_price(product_name: "cola")
    drink = InventoryControl.product_search(product_name: product_name, number_of_items: @drinks)
    stock_of_drinks = InventoryControl.stock_number(product_name: drink[1].name, number_of_items: @stock_of_drinks)
    drink[1].name
    drink[1].price
    stock_of_drinks[1].number
  end
end