# 確認手順

```
require './lib/vending_machine'
v = VendingMachine.new
p v.stock_info
p v.stock_count
v.stock(Drink.monster)
v.stock(Drink.cola)
v.insert(120)
v.insert(500)
p v.stock_info
p v.purchase('cola')
p v.stock_info
p v.refund
p v.stock_info
```