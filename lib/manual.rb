module Manual

  def self.first_message
    print  <<-TEXT
----------------------------------------------------------
こんにちは自販機プログラムへようこそ、指示通りに従ってね！
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
  
----------------------------------------------------------
最初はvm=VendingMachine.newしよう!

Manual.manual_messageでマニュアルを確認できるよ！
----------------------------------------------------------
    TEXT
  end

  def initialize_message
    print <<-TEXT
----------------------------------------------------------
よくできたね!

続いてお金投入コマンドを打ち込んでみよう！

□使用可能なお金投入コマンド
vm.insert_coin(10)
vm.insert_coin(50)
vm.insert_coin(100)
vm.insert_coin(500)
vm.insert_coin(1000)

□マニュアル表示コマンド
Manual.manual_message
----------------------------------------------------------
    TEXT
  end

  def self.manual_message
    print <<-TEXT
----------------------------------------------------------
manual(コマンド一覧)

----------------------------------------------------------
お金投入コマンド
vm.insert_coin(お金)

使用例）
vm.insert_coin(10)
vm.insert_coin(50)
vm.insert_coin(100)
vm.insert_coin(500)
vm.insert_coin(1000)

投入したお金が対象のお金だったら使用可能だよ！

----------------------------------------------------------
払い戻しコマンド
vm.refund

払い戻しが出来るよ！

----------------------------------------------------------
合計金額確認コマンド
vm.current_total

現在の合計金額を確認出来るよ！

----------------------------------------------------------
売上確認コマンド
vm.current_sales

現在の売上を確認出来るよ！

----------------------------------------------------------
お釣り確認コマンド
vm.current_change

現在のお釣りを確認出来るよ！

----------------------------------------------------------
ドリンク補充コマンド
vm.drink_replenishment

ドリンクの初期補充が出来るよ！

使用例）
vm.drink_replenishment(:cola)
vm.drink_replenishment(:redbull)
vm.drink_replenishment(:water)

----------------------------------------------------------
ラインナップ確認コマンド
vm.list_of_drinks

ラインナップが確認出来るよ！

----------------------------------------------------------
購入可能一覧確認コマンド
vm.available_drinks

現在の合計金額で購入できる飲み物一覧を確認できるよ！

----------------------------------------------------------
対象飲料を購入確認コマンド
vm.available?(:飲み物名)

飲み物が購入できるか確認出来るよ！

使用例）
vm.available?(:cola)
vm.available?(:redbull)
vm.available?(:water)

----------------------------------------------------------
対象商品購入コマンド
vm.purchased(:飲み物名)

飲み物が購入出来るよ！

使用例)colaかredbullかwater
vm.purchased(:cola)
vm.purchased(:redbull)
vm.purchased(:water)

----------------------------------------------------------
在庫確認コマンド
vm.product_information

使用例）
vm.product_information
vm.product_information(:redbull)
vm.product_information(:water)

在庫情報を確認出来るよ！

----------------------------------------------------------
    TEXT
  end
end