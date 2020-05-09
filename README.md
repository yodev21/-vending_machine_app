# 使用方法

```
# irb起動
irb

# ファイル読み込み
require './lib/vending_machine'

# マニュアルの表示
Manual.manual_message

# 自動販売機の作成
vm = vendingMachine=VendingMachine.new

# ドリンク補充
vm.drink_replenishment
vm.drink_replenishment(drink_name: "redbull", number: 1)
vm.drink_replenishment(drink_name: "water", number: 1)
# ※引数なしだとコーラが1本補充されます。
#  drink_nameに「redbull」、「water」を指定し、
#  引数に任意の数字を入れることでその値分加算可能です。

# ドリンクの在庫確認
vm.list_of_drinks # => [[:cola, 120, 6], [:redbull, 200, 2], [:water, 100, 2]]

vm.drinks_available_for_purchase # => []

# お金の投入
vm.in(500) # => nil
# ※投入金額可能コマンド一覧
#  vm.in(10)
#  vm.in(50)
#  vm.in(100)
#  vm.in(500)
#  vm.in(1000)

vm.drinks_available_for_purchase # => [[:cola, 120, 6], [:redbull, 200, 2], [:water, 100, 2]]

# 未対応のお金を投入した場合
vm.in(1) # => 1

# 投入金額の表示
vm.current_total

# 購入可能である在庫の一覧を確認(金額が足りている場合)
vm.do_you_change_this_drink?("cola") # => true
vm.do_you_change_this_drink?("redbull") # => true
vm.do_you_change_this_drink?("water") # => true

# ドリンク購入処理(金額が足りている場合)
vm.buy_a_drink("cola") # => [:cola, 120, 5]
vm.buy_a_drink("redbull") # => [:redbull, 200, 2]
vm.buy_a_drink("water") # => [:water, 100, 2]

# ドリンク購入処理(金額が足りない場合)
vm.buy_a_drink("redbull") # => false

# 購入可能である在庫の一覧を確認(金額が足りない場合)
vm.do_you_change_this_drink?("redbull") # => false

# 投入金額の払い戻し
vm.return # => 500

# 売り上げ合計金額の確認
vm.current_sales # => 420

# 終了
exit
```

# 確認コマンド(開発用)

```
irb
require './lib/vending_machine'
vm = vendingMachine=VendingMachine.new

vm.drink_replenishment
vm.drink_replenishment(drink_name: "redbull", number: 1)
vm.drink_replenishment(drink_name: "water", number: 3)
vm.list_of_drinks

vm.buy_a_drink("water")
vm.list_of_drinks

vm.in(500)
vm.drinks_available_for_purchase
vm.in(500)
# vm.return
vm.current_sales
vm.list_of_drinks
vm.do_you_change_this_drink?("cola") # => true
vm.do_you_change_this_drink?("redbull") # => true
vm.do_you_change_this_drink?("water")
vm.buy_a_drink("cola")
vm.buy_a_drink("redbull")
vm.buy_a_drink("water")

# その他コマンド
vm.current_sales
vm.current_total
vm.current_change
vm.cola_price
vm.number_of_cola
vm.name_cola
vm.redbull_price
vm.number_of_redbull
vm.name_redbull
vm.water_price
vm.number_water
vm.name_water
```

# 開発体制
leader  : 田中遥介  
observer: 恵藤昌也  
driver  : 川崎瑛仁 

# フローチャート
![vending_machine_flowchart](https://user-images.githubusercontent.com/60313195/78471505-bf6d3500-776c-11ea-9421-231f37d0888b.png)

# 開発手順
リポジトリのクローン(初回のみ)
```
git clone https://github.com/yodev21/vending_machine_app.git
```

## コミットメッセージのルール
※出来るだけ意識しとく
```
git commit -m 'Add コミットメッセージ  #issue番号'
# 機能追加       : Add
# 修正          : Fix
# リファクタリング: Refactor
# 削除          : Remove
例) 計算機能を追加の場合
    git commit -m 'Add 計算機能の追加 #1'
```
## GitHub Flow
各メンバーはdevelopブランチからトピックブランチを作成し、
機能作成が完了次第、PullRequestを行う。

リーダーは内容を確認し、問題がなければdevelopoブランチにmergeする。

developブランチにて動作確認を行い問題がなければmasterブランチにmergeする。

### developブランチをpull
```
git pull origin develop
```


### トピックブランチを作成
```
git checkout -b ○○
```

### トピックブランチが完成した場合、Githubにプッシュ
```
git add .
git commit -m 'Add コミットメッセージ  #issue番号'
git push origin トピックブランチ名
```

### トピックブランチからdevelopブランチへのPullRequestを行う

### 
# 開発環境
`Ruby: 2.6.5`

###  インストール方法
指定したRubyのバージョンのインストールコマンド
```
rbenv install 2.6.5
```

インストールしたRubyを使用可能な状態にするコマンド
```
rbenv rehash
```

Rubyバージョン切り替えコマンド
```
rbenv global 2.6.5
```

バージョン確認コマンド
```
ruby -v
```

# 機能一覧
・お金の投入機能（複数可）  
・投入金額の総計機能  
・払い戻し機能  
・扱えないお金の払い戻し機能  
・購入機能  
・購入後の釣り銭表示機能  
・商品管理機能  
・売上管理機能  
・在庫管理機能  
・購入可能リスト表示機能  

