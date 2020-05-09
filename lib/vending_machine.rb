require './lib/drink'
require './lib/manual'
require './lib/message'
require './lib/money'
require './lib/cash_register'
require './lib/stock'

class VendingMachine
  include Manual
  include Message
  include Money

  Manual.first_message

  def initialize
    cash_register
    drink
    stock_number
    initialize_message
  end

  def cash_register
    @regi = CashRegister.new(total: 0, sales: 0, change: 0)
  end

  def drink
    @cola = Drink.cola
    @redbull = Drink.redbull
    @water = Drink.water
  end

  def stock_number
    @cola_inventory = Stock.new(drink_name: "cola", number: 5)
    @redbull_inventory = Stock.new(drink_name: "redbull", number: 1)
    @water_inventory = Stock.new(drink_name: "water", number: 1)
  end

  #お金投入
  def in(money)
    if Money::MONEY.include?(money)
      Message.insert_message(money)
      @regi.add_total(money)
      Message.current_total_message(total: @regi.total)
    else
      Message.insert_error_message(money, @regi.total)
      @regi.current_change(money)
      Message.current_change_message(@regi.change)
    end
  end

  #払い戻し
  def return
    @regi.refund
    Message.refund_message(@regi.change)
  end

  def drink_cola_replenishment(number = 1)
    Message.replenishment_message(drink_name: "cola")
    @redbull_inventory.replenishment(number: number)
  end
  
  def drink_redbull_replenishment(number = 1)
    Message.replenishment_message(drink_name: "redbull")
    @redbull_inventory.replenishment(number: number)
  end

  def drink_water_replenishment(number = 1)
    Message.replenishment_message(drink_name: "water")
    @water_inventory.replenishment(number: number)
  end

  #ラインナップ確認
  def list_of_drinks
    Message.lineup_message
    unless  @cola_inventory.number == 0
      Message.lineup_drink_message(drink_name: @cola.name, 
                                   drink_price: @cola.price, 
                                   drink_number: @cola_inventory.number)
    end

    unless @redbull_inventory.number == 0
      Message.lineup_drink_message(drink_name: @redbull.name, 
                                   drink_price: @redbull.price, 
                                   drink_number: @redbull_inventory.number)
    end

    unless @water_inventory.number == 0
      Message.lineup_drink_message(drink_name: @water.name, 
                                   drink_price: @water.price, 
                                   drink_number: @water_inventory.number)
    end

  end

  #買えるものを表示
  def drinks_available_for_purchase
    Message.available_for_purchase_lineup_message

    if @regi.total >= @cola.price
      Message.lineup_drink_message(drink_name: @cola.name, 
                                   drink_price: @cola.price, 
                                   drink_number: @cola_inventory.number)
    end

    if @regi.total >= @redbull.price
      Message.lineup_drink_message(drink_name: @redbull.name, 
                                   drink_price: @redbull.price, 
                                   drink_number: @redbull_inventory.number)
    end

    if @regi.total >= @water.price
      Message.lineup_drink_message(drink_name: @water.name, 
                                   drink_price: @water.price, 
                                   drink_number: @water_inventory.number)
    end
  end

  #飲み物が買えるか確認
  def do_you_change_this_drink(drink)
    if drink == "cola"
      Message.available_for_purchase_drink_message(drink_name: "cola")
      if @regi.total >= @cola.price && @cola_inventory.number != 0
        Message.available_for_purchase_message(drink_name: "cola")
      elsif @regi.total >= @cola.price && @cola_inventory.number == 0
        Message.inventory_shortage_message
      elsif
        @regi.total < @cola.price
        Message.lack_of_money(drink_name: "cola")
      end

    elsif drink == "redbull"
      Message.available_for_purchase_drink_message(drink_name: "redbull")
      if @regi.total >= @redbull.price && @redbull_inventory.number != 0
        Message.available_for_purchase_message(drink_name: "redbull")
      elsif @regi.total >= @redbull.price && @redbull_inventory.number == 0
        Message.inventory_shortage_message
      elsif
        @regi.total < @redbull.price
        Message.lack_of_money(drink_name: "redbull")
      end

    elsif drink == "water"
      Message.available_for_purchase_drink_message(drink_name: "water")
      if @regi.total >= @water.price && @water_inventory.number != 0
        Message.available_for_purchase_message(drink_name: "water")
      elsif @regi.total >= @water.price && @water_inventory.number == 0
        Message.inventory_shortage_message
      elsif
        @regi.total < @water.price
        Message.lack_of_money(drink_name: "water")
      end
    end
  end

  #飲み物購入
  def buy_a_drink(drink)
    if drink == "cola"
      Message.buy_a_drink_message(drink_name: "cola")
      if @regi.total >= @cola.price && @cola_inventory.number != 0
        Message.purchased_a_drink_message(drink_name: "cola")
        @regi.buy(@cola.price)
        Message.subtraction_process_message(drink_price: @cola.price)
        Message.current_total_message(total: @total)
        @regi.add_sales(@cola.price)
        Message.add_sales_message(price: @cola.price)
        @cola_inventory.shipment
        Message.current_stock_number(drink_name: "cola", 
                                     drink_number: @cola_inventory.number)
      elsif @regi.total >= @cola.price && @cola_inventory.number == 0
        Message.not_available_due_to_ack_of_stock_message
      elsif
        @regi.total < @cola.price
        Message.do_not_have_enough_money_to_buy(drink_name: "cola")
      end

    elsif drink == "redbull"
      Message.buy_a_drink_message(drink_name: "redbull")
      if @regi.total >= @redbull.price && @redbull_inventory.number != 0
        Message.purchased_a_drink_message(drink_name: "redbull")
        @regi.buy(@redbull.price)
        Message.subtraction_process_message(drink_price: @redbull.price)
        Message.current_total_message(total: @total)
        @regi.add_sales(@redbull.price)
        Message.add_sales_message(price: @redbull.price)
        @redbull_inventory.shipment
        Message.current_stock_number(drink_name: "redbull", 
                                     drink_number: @redbull_inventory.number)
      elsif @regi.total >= @drink_redbull.price && @redbull_inventory.number == 0
        Message.not_available_due_to_ack_of_stock_message
      elsif
        @regi.total < @redbull.price
        Message.do_not_have_enough_money_to_buy(drink_name: "redbull")
      end

    elsif drink == "water"
      puts "水を購入します"
      Message.buy_a_drink_message(drink_name: "water")
      if @regi.total >= @water.price && @water_inventory.number != 0
        Message.purchased_a_drink_message(drink_name: "water")
        @regi.buy(@water.price)
        Message.subtraction_process_message(drink_price: @water.price)
        Message.current_total_message(total: @total)
        @regi.add_sales(@water.price)
        Message.add_sales_message(price: @water.price)
        @water_inventory.shipment
        Message.current_stock_number(drink_name: "water", 
                                     drink_number: @water_inventory.number)
      elsif @regi.total >= @drink_water.price && @water_inventory.number == 0
        Message.not_available_due_to_ack_of_stock_message
      elsif
        @regi.total < @water.price
        Message.do_not_have_enough_money_to_buy(drink_name: "water")
      end

    end
  end

  #売上確認
  def current_sales
    @regi.sales
  end

  #トータル残金確認
  def current_total
    @regi.total
  end

  #お釣り
  def current_change
    @regi.change
  end

  #コーラ情報
  #コーラの価格を確認
  def cola_price
    @cola.price
  end

  #コーラの本数確認
  def number_of_cola
    @cola_inventory.number
  end

  #コーラの名前確認
  def name_cola
    @cola.name
  end

  #レッドブル情報
  #レッドブルの価格を確認
  def redbull_price
    @redbull.price
  end

  #レッドブルの本数確認
  def number_of_redbull
    @redbull_inventory.number
  end
  
  #レッドブルの名前確認
  def name_redbull
    @redbull.name
  end

  #水の情報
  #水の価格を確認
  def water_price
    @water.price
  end

  #水の本数確認
  def number_water
    @water_inventory.number
  end

  #水の名前確認
  def name_water
    @water.name
  end
end

