require './lib/drink'
require './lib/manual'
require './lib/message'
require './lib/money'
class VendingMachine
  include Manual
  include Message
  include Money

  attr_accessor :total, :sales, :change

  Manual.first_message

  def initialize
    @total = 0
    @sales = 0
    @change = 0
    initialize_message
  end

  #お金投入
  def in(money)
    if Money::MONEY.include?(money)
      Message.insert_message(money)
      self.total += money
      Message.current_total_message(total: @total)
    else
      Message.insert_error_message(money, total)
      self.change = money
      Message.current_change_message(@change)
    end
  end


  #払い戻し
  def return
    self.change = @total
    self.total = 0
    Message.refund_message(@change)
  end


  #初期補充
  def drink_replenishment
    Message.replenishment_message
    @drink_cola = Drink.cola
  end


  #追加補充
  def drink_redbull_replenishment
    Message.replenishment_message(drink_name: "redbull")
    @drink_redbull = Drink.redbull
  end

  def drink_water_replenishment
    Message.replenishment_message(drink_name: "water")
    @drink_water = Drink.water
  end

  #レッドブルの本数追加
  def add_one_redbull
    Message.replenishment_message(drink_name: "redbull")
    @drink_redbull.number += 1
  end

  #水の本数追加
  def add_one_water
    Message.replenishment_message(drink_name: "water")
    @drink_water.number += 1
  end

  #ラインナップ確認
  def list_of_drinks
    Message.lineup_message
    unless @drink_cola.nil?
      Message.lineup_drink_message(drink_name: @drink_cola.name, 
                                   drink_price: @drink_cola.price, 
                                   drink_number: @drink_cola.number)
    end

    unless @drink_redbull.nil?
      Message.lineup_drink_message(drink_name: @drink_redbull.name, 
                                   drink_price: @drink_redbull.price, 
                                   drink_number: @drink_redbull.number)
    end

    unless @drink_water.nil?
      Message.lineup_drink_message(drink_name: @drink_water.name, 
                                   drink_price: @drink_water.price, 
                                   drink_number: @drink_water.number)
    end

  end

  #買えるものを表示
  def drinks_available_for_purchase
    Message.available_for_purchase_lineup_message

    if @total >= @drink_cola.price
      Message.lineup_drink_message(drink_name: @drink_cola.name, 
                                   drink_price: @drink_cola.price, 
                                   drink_number: @drink_cola.number)
    end

    if @total >= @drink_redbull.price
      Message.lineup_drink_message(drink_name: @drink_redbull.name, 
                                   drink_price: @drink_redbull.price, 
                                   drink_number: @drink_redbull.number)
    end

    if @total >= @drink_water.price
      Message.lineup_drink_message(drink_name: @drink_water.name, 
                                   drink_price: @drink_water.price, 
                                   drink_number: @drink_water.number)
    end
  end


  #飲み物が買えるか確認
  def do_you_change_this_drink(drink)
    if drink == "cola"
      Message.available_for_purchase_drink_message(drink_name: "cola")
      if @total >= @drink_cola.price && number_cola != 0
        Message.available_for_purchase_message(drink_name: "cola")
      elsif @total >= @drink_cola.price && number_cola == 0
        Message.inventory_shortage_message
      elsif
        @total < @drink_cola.price
        Message.lack_of_money(drink_name: "cola")
      end

    elsif drink == "redbull"
      Message.available_for_purchase_drink_message(drink_name: "redbull")
      if @total >= @drink_redbull.price && number_redbull != 0
        Message.available_for_purchase_message(drink_name: "redbull")
      elsif @total >= @drink_redbull.price && number_redbull == 0
        Message.inventory_shortage_message
      elsif
        @total < @drink_redbull.price
        Message.lack_of_money(drink_name: "redbull")
      end

    elsif drink == "water"
      Message.available_for_purchase_drink_message(drink_name: "water")
      if @total >= @drink_water.price && number_water != 0
        Message.available_for_purchase_message(drink_name: "water")
      elsif @total >= @drink_water.price && number_water == 0
        Message.inventory_shortage_message
      elsif
        @total < @drink_water.price
        Message.lack_of_money(drink_name: "water")
      end
    end
  end


  #飲み物購入
  def buy_a_drink(drink)
    if drink == "cola"
      Message.buy_a_drink_message(drink_name: "cola")
      if @total >= @drink_cola.price && number_cola != 0
        Message.purchased_a_drink_message(drink_name: "cola")
        self.total -= @drink_cola.price
        Message.subtraction_process_message(drink_price: @drink_cola.price)
        Message.current_total_message(total: @total)
        self.sales += @drink_cola.price
        Message.add_sales_message(price: @drink_cola.price)
        @drink_cola.number -= 1
        Message.current_stock_number(drink_name: "cola", 
                                     drink_number: @drink_cola.number)
      elsif @total >= @drink_cola.price && number_cola == 0
        Message.not_available_due_to_ack_of_stock_message
      elsif
        @total < @drink_cola.price
        Message.do_not_have_enough_money_to_buy(drink_name: "cola")
      end

    elsif drink == "redbull"
      Message.buy_a_drink_message(drink_name: "redbull")
      if @total >= @drink_redbull.price && number_redbull != 0
        Message.purchased_a_drink_message(drink_name: "redbull")
        self.total -= @drink_redbull.price
        Message.subtraction_process_message(drink_price: @drink_redbull.price)
        Message.current_total_message(total: @total)
        self.sales += @drink_redbull.price
        Message.add_sales_message(price: @drink_redbull.price)
        @drink_redbull.number -= 1
        Message.current_stock_number(drink_name: "redbull", 
                                     drink_number: @drink_redbull.number)
      elsif @total >= @drink_redbull.price && number_redbull == 0
        Message.not_available_due_to_ack_of_stock_message
      elsif
        @total < @drink_redbull.price
        Message.do_not_have_enough_money_to_buy(drink_name: "redbull")
      end

    elsif drink == "water"
      puts "水を購入します"
      Message.buy_a_drink_message(drink_name: "water")
      if @total >= @drink_water.price && number_water != 0
        Message.purchased_a_drink_message(drink_name: "water")
        self.total -= @drink_water.price
        Message.subtraction_process_message(drink_price: @drink_water.price)
        Message.current_total_message(total: @total)
        self.sales += @drink_water.price
        Message.add_sales_message(price: @drink_water.price)
        @drink_water.number -= 1
        Message.current_stock_number(drink_name: "water", 
                                     drink_number: @drink_water.number)
      elsif @total >= @drink_water.price && number_water == 0
        Message.not_available_due_to_ack_of_stock_message
      elsif
        @total < @drink_water.price
        Message.do_not_have_enough_money_to_buy(drink_name: "water")
      end

    end
  end



  #売上確認
  def sales_now
    @sales
  end

  #トータル残金確認
  def total_now
    @total
  end

  #お釣り
  def change_now
    @change
  end

  #コーラ情報
  #コーラの価格を確認
  def cola_kakaku
    @drink_cola.price
  end

  #コーラの本数確認
  def number_cola
    @drink_cola.number
  end

  #コーラの名前確認
  def name_price
    @drink_cola.name
  end


  #レッドブル情報
  #レッドブルの価格を確認
  def redbull_kakaku
    @drink_redbull.price
  end

  #レッドブルの本数確認
  def number_redbull
    @drink_redbull.number
  end


  #水の情報
  #水の本数確認
  def number_water
    @drink_water.number
  end

end

