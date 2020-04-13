# 確認手順

```
require './lib/vending_machine'
vm = vendingMachine=VendingMachine.new
# マニュアルの確認
vm.manual
# お金の投入(500)
vm.in(500)
```

不要
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