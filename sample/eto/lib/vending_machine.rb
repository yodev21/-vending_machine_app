require './drink'

class VendingMachine
#Money_tonyu = [10,50,100,500,1000].freeze

  attr_accessor :total, :uriage, :oturi

  def initialize
    @total = 0
    @uriage = 0
    @oturi = 0
    puts "よくできたね、偉いよ!"
    puts "続いてお金投入メソッドを打ち込もう！"
  end

puts "------------------------------------"
puts "こんにちは自販機プログラムへようこそ、指示通りに従ってね！"
puts "------------------------------------"
puts "1:最初はvendingMachine=VendingMachine.newしよう"
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
      self.oturi += money
      puts "現在のお釣りは#{@oturi}円です"
    end
  end


#払い戻し
  def return
    self.oturi += @total
    self.total = 0
    puts "合計#{@oturi}円のお釣りだよ"
  end


#初期補充
  def drink_hozyu
    puts "初期補充をしました"
    @drink_cola = Drink.cola
  end


#追加補充
  def drink_redbull_hozyu
    puts "レッドブルを補充をしました"
    @drink_redbull = Drink.redbull
  end

  def drink_water_hozyu
    puts "水を補充をしました"
    @drink_water = Drink.water
  end

#レッドブルの本数追加
 def honsu_redbull_insert_1
   @drink_redbull.honsu += 1
 end

 #水の本数追加
  def honsu_water_insert_1
    @drink_water.honsu += 1
  end


#ラインナップ確認
  def all
    puts "現在のラインナップ"
    unless @drink_cola.nil?
    puts "#{@drink_cola.name},#{@drink_cola.price}円,#{@drink_cola.honsu}本"
    end

    unless @drink_redbull.nil?
    puts "#{@drink_redbull.name},#{@drink_redbull.price}円,#{@drink_redbull.honsu}本"
    end

    unless @drink_water.nil?
    puts "#{@drink_water.name},#{@drink_water.price}円,#{@drink_water.honsu}本"
    end

  end

#買えるものを表示
  def all_line
    puts "現在のラインナップが買えるか確認"

      if @total >= @drink_cola.price
        puts "#{@drink_cola.name},#{@drink_cola.price}円,#{@drink_cola.honsu}本"
      end

      if @total >= @drink_redbull.price
        puts "#{@drink_redbull.name},#{@drink_redbull.price}円,#{@drink_redbull.honsu}本"
      end

      if @total >= @drink_water.price
        puts "#{@drink_water.name},#{@drink_water.price}円,#{@drink_water.honsu}本"
      end
  end


#コーラが買えるか確認
  def konyu_kakunin(drink)
    if drink == "cola"
      puts "コーラが買えるか確認します"
      if @total >= @drink_cola.price && honsu_cola != 0
        puts "在庫があり、金額が足りるのでコーラを購入できます"
      elsif @total >= @drink_cola.price && honsu_cola == 0
        puts "金額は足りますが、在庫がありません。"
      elsif
        @total < @drink_cola.price
        puts "金額が足りないのでコーラを購入できません"
      end

    elsif drink == "redbull"
      puts "レッドブルが買えるか確認します"
      if @total >= @drink_redbull.price && honsu_redbull != 0
        puts "在庫があり、金額が足りるのでレッドブルを購入できます"
      elsif @total >= @drink_redbull.price && honsu_redbull == 0
        puts "金額は足りますが、在庫がありません。"
      elsif
        @total < @drink_redbull.price
        puts "金額が足りないのでレッドブルを購入できません"
      end

    elsif drink == "water"
      puts "水が買えるか確認します"
      if @total >= @drink_water.price && honsu_water != 0
        puts "在庫があり、金額が足りるので水を購入できます"
      elsif @total >= @drink_water.price && honsu_water == 0
        puts "金額は足りますが、在庫がありません。"
      elsif
        @total < @drink_water.price
        puts "金額が足りないので水を購入できません"
      end
    end
  end


#コーラ購入
  def konyu_zikkou_test(drink)
    if drink == "cola"
      puts "コーラを購入します"
      if @total >= @drink_cola.price && honsu_cola != 0
        puts "在庫があり、金額が足りるのでコーラを購入しました"
        self.total -= @drink_cola.price
        puts "合計金額から#{@drink_cola.price}円が引かれました"
        puts "現在の合計金額は#{@total}円です"
        self.uriage += @drink_cola.price
        puts "売上金に#{@drink_cola.price}円を追加しました"
        @drink_cola.honsu -= 1
        puts "現在のコーラの本数は#{@drink_cola.honsu}本です"
      elsif @total >= @drink_cola.price && honsu_cola == 0
        puts "金額は足りますが、在庫がありませんので購入できませんでした"
      elsif
        @total < @drink_cola.price
        puts "金額が足りないのでコーラを購入できませんでした"
      end


    elsif drink == "redbull"
      puts "レッドブルを購入します"
      if @total >= @drink_redbull.price && honsu_redbull != 0
        puts "在庫があり、金額が足りるのでレッドブルを購入しました"
        self.total -= @drink_redbull.price
        puts "合計金額から#{@drink_redbull.price}円が引かれました"
        puts "現在の合計金額は#{@total}円です"
        self.uriage += @drink_redbull.price
        puts "売上金に#{@drink_redbull.price}円を追加しました"
        @drink_redbull.honsu -= 1
        puts "現在のレッドブルの本数は#{@drink_redbull.honsu}本です"
      elsif @total >= @drink_redbull.price && honsu_redbull == 0
        puts "金額は足りますが、在庫がありませんので購入できませんでした"
      elsif
        @total < @drink_redbull.price
        puts "金額が足りないのでレッドブルを購入できませんでした"
      end

    elsif drink == "water"
      puts "水を購入します"
      if @total >= @drink_water.price && honsu_water != 0
        puts "在庫があり、金額が足りるので水を購入しました"
        self.total -= @drink_water.price
        puts "合計金額から#{@drink_water.price}円が引かれました"
        puts "現在の合計金額は#{@total}円です"
        self.uriage += @drink_water.price
        puts "売上金に#{@drink_water.price}円を追加しました"
        @drink_water.honsu -= 1
        puts "現在の水の本数は#{@drink_water.honsu}本です"
      elsif @total >= @drink_water.price && honsu_water == 0
        puts "金額は足りますが、在庫がありませんので購入できませんでした"
      elsif
        @total < @drink_water.price
        puts "金額が足りないので水を購入できませんでした"
      end

    end
  end



#売上確認
  def uriage_now
    @uriage
  end

#トータル残金確認
  def total_now
    @total
  end

#お釣り
  def oturi_now
    @oturi
  end

#コーラ情報
#コーラの価格を確認
  def cola_kakaku
    @drink_cola.price
  end

  #コーラの本数確認
    def honsu_cola
      @drink_cola.honsu
    end

    #コーラの名前確認
      def name_cola
        @drink_cola.name
      end


#レッドブル情報
#レッドブルの価格を確認
  def redbull_kakaku
    @drink_redbull.price
  end

#レッドブルの本数確認
def honsu_redbull
  @drink_redbull.honsu
end


#水の情報
#水の本数確認
def honsu_water
  @drink_water.honsu
end




def manual
  puts "こんにちは自販機プログラムへようこそ、指示通りに従ってね！"
  puts "------------------------------------"
  puts "1:最初はvendingMachine=VendingMachine.newしよう"
  puts "------------------------------------"
  puts "2:vendingMachine.in(お金)は入れたお金で対象の金額だったら使用OK"
  puts "------------------------------------"
  puts "3:vendingMachine.totalで現在の合計金額を確認できるよ"
  puts "------------------------------------"
  puts "3.1:vendingMachine.uriageで現在の売上を確認できるよ"
  puts "------------------------------------"
  puts "3.2:vendingMachine.oturiで現在のお釣りを確認できるよ"
  puts "------------------------------------"
  puts "4:vendingMachine.drink_hozyuでドリンクの初期補充をしよう!"
  puts "------------------------------------"
  puts "5:vendingMachine.allでラインナップ確認!"
  puts "------------------------------------"
  puts "6:vendingMachine.konyu_kakunin("")で飲み物が購入できるか確認できる colaかredbullかwater"
  puts "------------------------------------"
  puts "7:vendingMachine.konyu_zikkou_test("")で飲み物が購入できる colaかredbullかwater"
  puts "------------------------------------"
  puts "8:vendingMachine.uriage_nowでも売上確認できる"
  puts "------------------------------------"
  puts "9:vendingMachine.total_nowでも合計金額が確認できる"
  puts "------------------------------------"
  puts "10:vendingMachine.honsu_colaでコーラの在庫本数を確認できる"
  puts "------------------------------------"
  puts "10.1:vendingMachine.honsu_redbullでレッドブルの在庫本数を確認できる"
  puts "------------------------------------"
  puts "10.2:vendingMachine.honsu_waterで水の在庫本数を確認できる"
  puts "------------------------------------"
  puts "10.3:vendingMachine.returnで払い戻し"
  puts "------------------------------------"
  puts "11:vendingMachine.manualでマニュアル表示"
  puts "------------------------------------"
  puts "12:vendingMachine.drink_redbull_hozyuでレッドブルを補充"
  puts "------------------------------------"
  puts "13:vendingMachine.drink_water_hozyuで水を補充"
  puts "------------------------------------"
  puts "14:vendingMachine.honsu_redbull_insert_1でレッドブル一本追加"
  puts "------------------------------------"
  puts "15:vendingMachine.honsu_water_insert_1で水を一本追加"
  puts "------------------------------------"
end



end
