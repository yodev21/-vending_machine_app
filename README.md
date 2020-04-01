# 開発体制
leader  : tanaka_yosuke  
observer: 恵藤昌也 
driver  : kawasaki_akihito

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

##リポジトリにプッシュ
```
git push origin master
```
# 開発環境
`Ruby: 2.6.5`

###  インストール方法
指定したRubyのバージョンのインストールコマンド
```
rbenv install 2.3.5
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
