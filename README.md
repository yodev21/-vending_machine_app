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

