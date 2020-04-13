require './drink'

class VendingMachine
#Money_tonyu = [10,50,100,500,1000].freeze

  attr_accessor :total, :sales, :change

  def initialize
    @total = 0
    @sales = 0
    @change = 0
    puts "よくできたね、偉いよ!"
    puts "続いてお金投入メソッドを打ち込もう！"
  end

puts "------------------------------------"
puts "こんにちは自販機プログラムへようこそ、指示通りに従ってね！"
puts "------------------------------------"
puts "最初はvendingMachine=VendingMachine.newしよう"
puts "------------------------------------"
puts "vendingMachine.manualでマニュアル表示"
puts "------------------------------------"

#お金投入
  def in(money)
    if money == 10 || money == 50 || money == 100 || money == 500 || money == 1000
      puts "#{money}円投入されました"
      self.total += money
      puts "現在の合計金額#{@total}円です"
    else
      puts "そのお金は受け付けていません"
      puts "#{money}円は残金に反映されませんでした"
      puts "#{money}円は払い戻しされました"
      puts "現在の合計金額#{@total}円です"
      self.change = money
      puts "現在のお釣りは#{@change}円です"
    end
  end


#払い戻し
  def return
    self.change = @total
    self.total = 0
    puts "合計#{@change}円のお釣りだよ"
  end


#初期補充
  def drink_replenishment
    puts "初期補充をしました"
    @drink_cola = Drink.cola
  end


#追加補充
  def drink_redbull_replenishment
    puts "レッドブルを補充をしました"
    @drink_redbull = Drink.redbull
  end

  def drink_water_replenishment
    puts "水を補充をしました"
    @drink_water = Drink.water
  end

#レッドブルの本数追加
 def add_one_redbull
   @drink_redbull.number += 1
 end

 #水の本数追加
  def add_one_water
    @drink_water.number += 1
  end


#ラインナップ確認
  def list_of_drinks
    puts "現在のラインナップ"
    unless @drink_cola.nil?
    puts "#{@drink_cola.name},#{@drink_cola.price}円,#{@drink_cola.number}本"
    end

    unless @drink_redbull.nil?
    puts "#{@drink_redbull.name},#{@drink_redbull.price}円,#{@drink_redbull.number}本"
    end

    unless @drink_water.nil?
    puts "#{@drink_water.name},#{@drink_water.price}円,#{@drink_water.number}本"
    end

  end

#買えるものを表示
  def drinks_available_for_purchase
    puts "現在のラインナップが買えるか確認"

      if @total >= @drink_cola.price
        puts "#{@drink_cola.name},#{@drink_cola.price}円,#{@drink_cola.number}本"
      end

      if @total >= @drink_redbull.price
        puts "#{@drink_redbull.name},#{@drink_redbull.price}円,#{@drink_redbull.number}本"
      end

      if @total >= @drink_water.price
        puts "#{@drink_water.name},#{@drink_water.price}円,#{@drink_water.number}本"
      end
  end


#飲み物が買えるか確認
  def do_you_change_this_drink(drink)
    if drink == "cola"
      puts "コーラが買えるか確認します"
      if @total >= @drink_cola.price && number_cola != 0
        puts "在庫があり、金額が足りるのでコーラを購入できます"
      elsif @total >= @drink_cola.price && number_cola == 0
        puts "金額は足りますが、在庫がありません。"
      elsif
        @total < @drink_cola.price
        puts "金額が足りないのでコーラを購入できません"
      end

    elsif drink == "redbull"
      puts "レッドブルが買えるか確認します"
      if @total >= @drink_redbull.price && number_redbull != 0
        puts "在庫があり、金額が足りるのでレッドブルを購入できます"
      elsif @total >= @drink_redbull.price && number_redbull == 0
        puts "金額は足りますが、在庫がありません。"
      elsif
        @total < @drink_redbull.price
        puts "金額が足りないのでレッドブルを購入できません"
      end

    elsif drink == "water"
      puts "水が買えるか確認します"
      if @total >= @drink_water.price && number_water != 0
        puts "在庫があり、金額が足りるので水を購入できます"
      elsif @total >= @drink_water.price && number_water == 0
        puts "金額は足りますが、在庫がありません。"
      elsif
        @total < @drink_water.price
        puts "金額が足りないので水を購入できません"
      end
    end
  end


#飲み物購入
  def buy_a_drink(drink)
    if drink == "cola"
      puts "コーラを購入します"
      if @total >= @drink_cola.price && number_cola != 0
        puts "在庫があり、金額が足りるのでコーラを購入しました"
        self.total -= @drink_cola.price
        puts "合計金額から#{@drink_cola.price}円が引かれました"
        puts "現在の合計金額は#{@total}円です"
        self.sales += @drink_cola.price
        puts "売上金に#{@drink_cola.price}円を追加しました"
        @drink_cola.number -= 1
        puts "現在のコーラの本数は#{@drink_cola.number}本です"
      elsif @total >= @drink_cola.price && number_cola == 0
        puts "金額は足りますが、在庫がありませんので購入できませんでした"
      elsif
        @total < @drink_cola.price
        puts "金額が足りないのでコーラを購入できませんでした"
      end


    elsif drink == "redbull"
      puts "レッドブルを購入します"
      if @total >= @drink_redbull.price && number_redbull != 0
        puts "在庫があり、金額が足りるのでレッドブルを購入しました"
        self.total -= @drink_redbull.price
        puts "合計金額から#{@drink_redbull.price}円が引かれました"
        puts "現在の合計金額は#{@total}円です"
        self.sales += @drink_redbull.price
        puts "売上金に#{@drink_redbull.price}円を追加しました"
        @drink_redbull.number -= 1
        puts "現在のレッドブルの本数は#{@drink_redbull.number}本です"
      elsif @total >= @drink_redbull.price && number_redbull == 0
        puts "金額は足りますが、在庫がありませんので購入できませんでした"
      elsif
        @total < @drink_redbull.price
        puts "金額が足りないのでレッドブルを購入できませんでした"
      end

    elsif drink == "water"
      puts "水を購入します"
      if @total >= @drink_water.price && number_water != 0
        puts "在庫があり、金額が足りるので水を購入しました"
        self.total -= @drink_water.price
        puts "合計金額から#{@drink_water.price}円が引かれました"
        puts "現在の合計金額は#{@total}円です"
        self.sales += @drink_water.price
        puts "売上金に#{@drink_water.price}円を追加しました"
        @drink_water.number -= 1
        puts "現在の水の本数は#{@drink_water.number}本です"
      elsif @total >= @drink_water.price && number_water == 0
        puts "金額は足りますが、在庫がありませんので購入できませんでした"
      elsif
        @total < @drink_water.price
        puts "金額が足りないので水を購入できませんでした"
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




def manual
    puts "------------------------------------"
    puts "manual"
    puts "------------------------------------"
    puts "お金投入"
    puts "------------------------------------"
    puts "vendingMachine.in(お金)は入れたお金で対象の金額だったら使用OK"
    puts "------------------------------------"
    puts ":払い戻し"
    puts "------------------------------------"
    puts "vendingMachine.returnで払い戻し"
    puts "------------------------------------"
    puts "合計金額、売上、お釣りを確認"
    puts "------------------------------------"
    puts "vendingMachine.totalで現在の合計金額を確認できるよ"
    puts "------------------------------------"
    puts "vendingMachine.salesで現在の売上を確認できるよ"
    puts "------------------------------------"
    puts "vendingMachine.changeで現在のお釣りを確認できるよ"
    puts "------------------------------------"
    puts "補充"
    puts "------------------------------------"
    puts "vendingMachine.drink_replenishmentでドリンクの初期補充をしよう!"
    puts "------------------------------------"
    puts "vendingMachine.drink_redbull_replenishmentでレッドブルを補充"
    puts "------------------------------------"
    puts "vendingMachine.drink_water_replenishmentで水を補充"
    puts "------------------------------------"
    puts "追加補充"
    puts "------------------------------------"
    puts "vendingMachine.add_one_redbullでレッドブル一本追加"
    puts "------------------------------------"
    puts "vendingMachine.add_one_waterで水を一本追加"
    puts "------------------------------------"
    puts "ラインナップ、購入できるものの一覧確認"
    puts "------------------------------------"
    puts "vendingMachine.list_of_drinksでラインナップ確認!"
    puts "------------------------------------"
    puts "vendingMachine.drinks_available_for_purchaseで現在の合計金額で購入できる飲み物一覧を出す!"
    puts "------------------------------------"
    puts "対象飲料を購入する"
    puts "------------------------------------"
    puts "vendingMachine.do_you_change_this_drink("")で飲み物が購入できるか確認できる colaかredbullかwater"
    puts "------------------------------------"
    puts "vendingMachine.buy_a_drink("")で飲み物が購入できる colaかredbullかwater"
    puts "------------------------------------"
    puts "おまけ"
    puts "------------------------------------"
    puts "vendingMachine.sales_nowでも売上確認できる"
    puts "------------------------------------"
    puts "vendingMachine.total_nowでも合計金額が確認できる"
    puts "------------------------------------"
    puts "vendingMachine.number_colaでコーラの在庫本数を確認できる"
    puts "------------------------------------"
    puts "vendingMachine.number_redbullでレッドブルの在庫本数を確認できる"
    puts "------------------------------------"
    puts "vendingMachine.number_waterで水の在庫本数を確認できる"
    puts "------------------------------------"
end



end

