require 'spec_helper'
describe InventoryControl do

  describe "商品補充処理機能" do
    context "補充処理を行われた場合" do
      it "在庫に加算されること" do
        product_name = :cola
        cola_inventory = Stock.new(product_name: :cola, number: 5)
        redbull_inventory = Stock.new(product_name: :redbull, number: 1)
        water_inventory = Stock.new(product_name: :water, number: 1)
        number_of_items = {cola: cola_inventory, redbull: redbull_inventory, water: water_inventory}

        expect(InventoryControl.product_replenishment(product_name: product_name, number_of_items: number_of_items, number: 1)).to eq(6)
      end

      it "在庫に複数加算されること" do
        product_name = :cola
        cola_inventory = Stock.new(product_name: :cola, number: 5)
        redbull_inventory = Stock.new(product_name: :redbull, number: 1)
        water_inventory = Stock.new(product_name: :water, number: 1)
        number_of_items = {cola: cola_inventory, redbull: redbull_inventory, water: water_inventory}

        expect(InventoryControl.product_replenishment(product_name: product_name, number_of_items: number_of_items, number: 2)).to eq(7)
      end
    end
  end

  describe "商品の一覧確認認処理" do
    context "一覧確認処理が行われた場合" do
      it "在庫が存在する商品一覧が表示されること" do
        cola = Drink.new(product_name: :cola, product_price: 120)
        redbull = Drink.new(product_name: :redbull, product_price: 200)
        water = Drink.new(product_name: :water, product_price: 100)
        products = {cola: cola, redbull: redbull, water: water}

        cola_inventory = Stock.new(product_name: :cola, number: 5)
        redbull_inventory = Stock.new(product_name: :redbull, number: 1)
        water_inventory = Stock.new(product_name: :water, number: 1)
        number_of_items = {cola: cola_inventory, redbull: redbull_inventory, water: water_inventory}

        expect(InventoryControl.get_product_list(product_list: products, 
                                                 number_of_items: number_of_items, 
                                                 cash_register: nil)).to eq([[:cola, 120, 5], 
                                                                             [:redbull, 200, 1], 
                                                                             [:water, 100, 1]])
      end

      it "購入可能でありかつ在庫が存在する商品一覧が表示されること(全て購入可能)" do
        cola = Drink.new(product_name: :cola, product_price: 120)
        redbull = Drink.new(product_name: :redbull, product_price: 200)
        water = Drink.new(product_name: :water, product_price: 100)
        products = {cola: cola, redbull: redbull, water: water}

        cola_inventory = Stock.new(product_name: :cola, number: 5)
        redbull_inventory = Stock.new(product_name: :redbull, number: 1)
        water_inventory = Stock.new(product_name: :water, number: 1)
        number_of_items = {cola: cola_inventory, redbull: redbull_inventory, water: water_inventory}
        cash_register = CashRegister.new(total: 1000, sales: 0, change: 0)
        expect(InventoryControl.get_product_list(product_list: products, 
                                                 number_of_items: number_of_items, 
                                                 cash_register: cash_register)).to eq([[:cola, 120, 5], 
                                                                                       [:redbull, 200, 1], 
                                                                                       [:water, 100, 1]])
      end

      it "購入可能でありかつ在庫が存在する商品一覧が表示されること(一部購入可能)" do
        cola = Drink.new(product_name: :cola, product_price: 120)
        redbull = Drink.new(product_name: :redbull, product_price: 200)
        water = Drink.new(product_name: :water, product_price: 100)
        products = {cola: cola, redbull: redbull, water: water}

        cola_inventory = Stock.new(product_name: :cola, number: 5)
        redbull_inventory = Stock.new(product_name: :redbull, number: 1)
        water_inventory = Stock.new(product_name: :water, number: 1)
        number_of_items = {cola: cola_inventory, redbull: redbull_inventory, water: water_inventory}
        cash_register = CashRegister.new(total: 100, sales: 0, change: 0)
        expect(InventoryControl.get_product_list(product_list: products, 
                                                 number_of_items: number_of_items, 
                                                 cash_register: cash_register)).to eq([[:water, 100, 1]])
      end
    end
  end

  describe "対象商品が購入可能か確認処理機能" do
    context "確認処理が行われた場合" do
      it "購入可能な対象の商品であればtrueが返ること" do
        cola = Drink.new(product_name: :cola, product_price: 120)
        redbull = Drink.new(product_name: :redbull, product_price: 200)
        water = Drink.new(product_name: :water, product_price: 100)
        products = {cola: cola, redbull: redbull, water: water}

        cola_inventory = Stock.new(product_name: :cola, number: 5)
        redbull_inventory = Stock.new(product_name: :redbull, number: 1)
        water_inventory = Stock.new(product_name: :water, number: 1)
        number_of_items = {cola: cola_inventory, redbull: redbull_inventory, water: water_inventory}
        cash_register = CashRegister.new(total: 120, sales: 0, change: 0)
        expect(InventoryControl.get_product?(product_name: :cola,
                                             product_list: products, 
                                             number_of_items: number_of_items, 
                                             cash_register: cash_register)).to eq({:item_name=>:cola,
                                                                                   :purchase_flg=>true, 
                                                                                   :reason=>"available_for_purchase"})
      end

      it "在庫の不足が原因で対象の商品が購入不可であればであればfalseが返ること" do
        cola = Drink.new(product_name: :cola, product_price: 120)
        redbull = Drink.new(product_name: :redbull, product_price: 200)
        water = Drink.new(product_name: :water, product_price: 100)
        products = {cola: cola, redbull: redbull, water: water}

        cola_inventory = Stock.new(product_name: :cola, number: 0)
        redbull_inventory = Stock.new(product_name: :redbull, number: 1)
        water_inventory = Stock.new(product_name: :water, number: 1)
        number_of_items = {cola: cola_inventory, redbull: redbull_inventory, water: water_inventory}

        cash_register = CashRegister.new(total: 120, sales: 0, change: 0)
        expect(InventoryControl.get_product?(product_name: :cola,
                                             product_list: products, 
                                             number_of_items: number_of_items, 
                                             cash_register: cash_register)).to eq({:item_name=>:cola,
                                                                                   :purchase_flg=>false, 
                                                                                   :reason=>"inventory_shortage"})
      end

      it "合計金額の不足が原因で対象の商品が購入不可であればであればfalseが返ること" do
        cola = Drink.new(product_name: :cola, product_price: 120)
        redbull = Drink.new(product_name: :redbull, product_price: 200)
        water = Drink.new(product_name: :water, product_price: 100)
        products = {cola: cola, redbull: redbull, water: water}

        cola_inventory = Stock.new(product_name: :cola, number: 0)
        redbull_inventory = Stock.new(product_name: :redbull, number: 1)
        water_inventory = Stock.new(product_name: :water, number: 1)
        number_of_items = {cola: cola_inventory, redbull: redbull_inventory, water: water_inventory}

        cash_register = CashRegister.new(total: 100, sales: 0, change: 0)
        expect(InventoryControl.get_product?(product_name: :cola,
                                             product_list: products, 
                                             number_of_items: number_of_items, 
                                             cash_register: cash_register)).to eq({:item_name=>:cola, 
                                                                                   :purchase_flg=>false, 
                                                                                   :reason=>"lack_of_money"})
      end
    end
  end

  describe "個別商品の情報確認処理機能" do
    context "確認処理が行われた場合" do
      it "対象の商品が表示されること" do
        cola = Drink.new(product_name: :cola, product_price: 120)
        redbull = Drink.new(product_name: :redbull, product_price: 200)
        water = Drink.new(product_name: :water, product_price: 100)
        products = {cola: cola, redbull: redbull, water: water}

        cola_inventory = Stock.new(product_name: :cola, number: 5)
        redbull_inventory = Stock.new(product_name: :redbull, number: 1)
        water_inventory = Stock.new(product_name: :water, number: 1)
        number_of_items = {cola: cola_inventory, redbull: redbull_inventory, water: water_inventory}

        product = InventoryControl.product_information(product_name: :cola,
                                                       product_list: products, 
                                                       number_of_items: number_of_items)
        expect(product[:product_name]).to eq(:cola)
        expect(product[:product_price]).to eq(120)
        expect(product[:number_of_items].number).to eq(5)
      end
    end
  end
end