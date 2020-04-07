#ここからZihankiクラス
#class Zihanki
def test1

money_zandaka = [] # 配列の定義
money_tonyu = [10,50,100,500,1000]

#入金
while true
puts "お金を投入して下さい#{money_tonyu}"
puts "111:投入完了"
money = gets.to_i
  if money == 10 || money == 50 || money == 100 || money == 500 || money == 1000
    money_zandaka << money # 変数を配列に代入
    puts "#{money}円を入れました"
  elsif money == 111
    puts "金額投入完了"
    break
  else
    puts "そのお金は受け付けていません"
  end

puts "投入したお金の額：#{money_zandaka.sum}"

end
#入金完了

puts "投入したお金の合計：#{money_zandaka.sum}"

#購入編　
cola = ["コーラ", 120, 5]
redbull = ["レッドブル", 200, 5]
mizu = ["水", 100, 5]


while true
puts "1:#{cola}"
puts "2:#{redbull}"
puts "3:#{mizu}"

puts "何を購入しますか"
drink = gets.to_i

if drink == 1
  if money_zandaka.sum >= cola[1]
    puts "コーラを選びます"
    puts "金額が足りるのでコーラを購入できます"
  elsif
    money_zandaka.sum < cola[1]
    puts "金額が足りません"
  end

  if cola[2] != 0
    kosu = cola[2] - 1
    puts "残り個数#{kosu}"
    cola[2] = kosu
    puts "現在の状況#{cola}"
    sasihiki = money_zandaka.sum - cola[1]
    puts "残高は#{sasihiki}円だよ"
    break
  elsif cola[2] == 0
    puts "残り個数がないよ"
  end

elsif drink == 2
  if money_zandaka.sum >= redbull[1]
    puts "レッドブルを選びます"
    puts "金額が足りるのでレッドブルを購入できます"
  elsif
    money_zandaka.sum < redbull[1]
    puts "金額が足りません"
  end

  if redbull[2] != 0
    kosu = redbull[2] - 1
    puts "残り個数#{kosu}"
    redbull[2] = kosu
    puts "現在の状況#{redbull}"
    sasihiki = money_zandaka.sum - redbull[1]
    puts "残高は#{sasihiki}円だよ"
    break
  elsif redbull[2] == 0
    puts "残り個数がないよ"
  end

elsif drink == 3
  if money_zandaka.sum >= mizu[1]
    puts "水を選びます"
    puts "金額が足りるので水を購入できます"
  elsif
    money_zandaka.sum < mizu[1]
    puts "金額が足りません"
  end

  if mizu[2] != 0
    kosu = mizu[2] - 1
    puts "残り個数#{kosu}"
    mizu[2] = kosu
    puts "現在の状況#{mizu}"
    sasihiki = money_zandaka.sum - mizu[1]
    puts "残高は#{sasihiki}円だよ"
    break
  elsif mizu[2] == 0
    puts "残り個数がないよ"
  end

else
  puts "もう一度選んで下さい"
end

end

#購入終了

#確認
#puts "現在の状況#{money_zandaka}"
#puts "現在の状況#{money_zandaka.sum}"


#puts "現在の状況#{cola}"
#puts "現在の状況#{redbull}"
#puts "現在の状況#{mizu}"
#

while true
puts "引き続き買うか？"
puts "1:買う"
puts "2:買わない"
saido = gets.to_i

if saido == 1
  puts "もう一回買う"
  test1()
elsif saido == 2
  puts "終わり"
  puts "お釣りは#{sasihiki}円だよ"
  break
else
  puts "1か2を入力して下さい"
end

end




end
#test1のメソッドのエンド

test1()

#end
#ここでZihankiクラスは完了

#def test2
#  test()
#end

#test1()
#test2()





#class Zihanki2
#  def zikken
#    zihanki.test1
#  end
#end


#zihanki = Zihanki.new
#zihanki.test1
#zihanki2 = Zihanki2.new
#zihanki2.zikken
