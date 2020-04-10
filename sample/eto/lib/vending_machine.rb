require './drink'

class VendingMachine
Money_tonyu = [10,50,100,500,1000].freeze

  attr_accessor :total

  def initialize
    @total = 0
    puts "よくできたね、偉いよ!"
    puts "続いてお金投入メソッドを打ち込もう！"
  end

puts "こんにちは自販機プログラムへようこそ、指示通りに従ってね！"

puts "
  ┏━┓ ┏━┓
  ┃　┃┃　┃
  ┃　┃┃　┃
  ┃　┃┃　┃
  ┃　┃┃　┃
 ┏┛　┗┛　┗┓
 ┃＞ ┳ ＜ ┃
 ┃ ◎┗┻┛◎  ┃
 ┃ ┏┓ ┏┓　┃　
  ┗┫┣━┫┣━━
"
puts "------------------------------------"
puts "1:最初はvendingMachine=VendingMachine.newしよう"
puts "------------------------------------"
puts "2:お金投入メソッドを紹介するよ"
puts "vendingMachine.in(お金)は入れたお金で対象の金額だったら使用OK"
puts "下記のメソッドは引数をなしで投入できるメソッドだよ！"
puts "in_10は10円投入"
puts "in_50は50円投入"
puts "in_100は100円投入"
puts "in_500は500円投入"
puts "in_1000は1000円投入"
puts "------------------------------------"
puts "3:vendingMachine.totalで現在の合計金額を確認できるよ"
puts "4:vendingMachine.drink_manualでドリンク購入説明に入るよ"



  def in(money)
    if money == 10 || money == 50 || money == 100 || money == 500 || money == 1000
      puts "#{money}円投入されました"
      self.total += money
      puts "現在の合計金額#{@total}円です"
    else
      puts "そのお金は受け付けていません"
      puts "#{money}円は残金に反映されませんでした"
      puts "現在の合計金額#{@total}円です"
    end
  end

  def in_10
    puts "10円投入されました"
    self.total += 10
  end

  def in_50
    puts "50円投入されました"
    self.total += 50
  end

  def in_100
    puts "100円投入されました"
    self.total += 100
  end

  def in_500
    puts "500円投入されました"
    self.total += 500
  end

  def in_1000
    puts "1000円投入されました"
    self.total += 1000
  end

  def return
    puts "#{@total}円の払い戻しだよ"
    puts "買わないなら帰れ!"
    self.total = 0
  end

  def drink_manual
    puts "コーラを補充,drink_cola = Drink.colaを入力"
    puts "レッドブルを補充,drink_redbull = Drink.redbullを入力"
    puts "水を補充,drink_water = Drink.waterを入力"
    puts "drink_manual2メソッドを入力してね"
  end

  def drink_manual2
    puts "変数に値が代入できているか確認しよう"
    puts "drink_cola"
    puts "drink_redbull"
    puts "drink_water"
    puts "drink_manual3メソッドはコーラを補充できるよ"
  end

  #def drink_manual3
  #  drink_cola = Drink.cola
  #end






end
