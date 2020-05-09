require 'spec_helper'
describe VendingMachine do

  describe "お金投入処理" do
    context "お金を投入した場合" do
      it "想定した金額であればnilを返すこと" do
        vm = vendingMachine=VendingMachine.new
        expect(vm.in(10)).to be nil
        expect(vm.in(50)).to be nil
        expect(vm.in(100)).to be nil
        expect(vm.in(500)).to be nil
        expect(vm.in(1000)).to be nil
      end
      it "Warn 想定外の金額であれば投入した金額を変えること" do
        vm = vendingMachine=VendingMachine.new
        expect(vm.in(1)).to be 1
      end
    end
  end

  describe "払い戻し処理" do
    context "払い戻し処理が行われた場合" do
      it "現在の投入金額が表示されること" do
        vm = vendingMachine=VendingMachine.new
        vm.in(500)
        vm.in(500)
        expect(vm.return).to be 1000
      end
    end
  end

  describe "ドリンク補充" do
    context "ドリンク補充が行われた場合" do
      it "colaの情報が表示されること" do
        vm = vendingMachine=VendingMachine.new
        expect(vm.drink_replenishment).to eq(["cola", 1])
      end

      it "redbullの情報が表示されること" do
        vm = vendingMachine=VendingMachine.new
        expect(vm.drink_replenishment(drink_name: "redbull", number: 1)).to eq(["redbull", 1])
      end

      it "waterの情報が表示されること" do
        vm = vendingMachine=VendingMachine.new
        expect(vm.drink_replenishment(drink_name: "water", number: 1)).to eq(["water", 1])
      end
    end
  end

  describe "ラインナップ確認処理" do
    context "在庫が存在する場合" do
      it "対象の商品が表示されること" do
        vm = vendingMachine=VendingMachine.new
        expect(vm.list_of_drinks).to eq([[:cola, 120, 5], [:redbull, 200, 1], [:water, 100, 1]])
      end
    end
    context "在庫が存在しない場合" do
      it "対象の商品が表示されないこと" do
        vm = vendingMachine=VendingMachine.new
        vm.in(1000)
        vm.in(1000)
        5.times do |n|
          vm.buy_a_drink("cola") 
        end
        vm.buy_a_drink("redbull")
        vm.buy_a_drink("water")
        vm.list_of_drinks
        expect(vm.list_of_drinks).to eq([])
      end
    end
  end

  describe "購入可能な商品の一覧確認認処理" do
    context "購入可能な商品が存在する場合" do
      it "対象の商品が表示されること" do
        vm = vendingMachine=VendingMachine.new
        vm.in(1000)
        expect(vm.drinks_available_for_purchase).to eq([[:cola, 120, 5], [:redbull, 200, 1], [:water, 100, 1]])
      end
    end
    context "購入可能な商品が存在しない場合" do
      it "[]が表示されること" do
        vm = vendingMachine=VendingMachine.new
        expect(vm.drinks_available_for_purchase).to eq([])

      end
    end
  end

  describe "対象ドリンクが購入可能か確認" do
    context "対象の商品が購入可能な場合" do
      it "trueが出力されること" do
        vm = vendingMachine=VendingMachine.new
        vm.in(1000)
        expect(vm.do_you_change_this_drink?("cola")).to be_truthy
        expect(vm.do_you_change_this_drink?("redbull")).to be_truthy
        expect(vm.do_you_change_this_drink?("water")).to be_truthy
      end
    end
    context "対象の商品が購入不可の場合" do
      it "falseが出力されること" do
        vm = vendingMachine=VendingMachine.new
        expect(vm.do_you_change_this_drink?("cola")).to be_falsey
        expect(vm.do_you_change_this_drink?("redbull")).to be_falsey
        expect(vm.do_you_change_this_drink?("water")).to be_falsey
      end
    end
  end

  describe "ドリンク購入処理" do
    context "購入可能な商品に対して購入処理を行った場合" do
      it "購入した商品情報が表示されること" do
        vm = vendingMachine=VendingMachine.new
        vm.in(1000)
        expect(vm.buy_a_drink("cola")).to include :cola, 120, 4
        expect(vm.buy_a_drink("redbull")).to include :redbull, 200, 0
        expect(vm.buy_a_drink("water")).to include :water, 100, 0
      end
    end
    context "購入不可能な商品に対して購入処理を行った場合" do
      it "falseが出力されること" do
        vm = vendingMachine=VendingMachine.new
        expect(vm.buy_a_drink("cola")).to be_falsey
        expect(vm.buy_a_drink("redbull")).to be_falsey
        expect(vm.buy_a_drink("water")).to be_falsey
      end
    end
  end
  
  describe "売上確認処理" do
    it "売り上げが出力されること" do
      vm = vendingMachine=VendingMachine.new
      vm.in(1000)
      vm.buy_a_drink("cola")
      expect(vm.current_sales).to eq 120
    end
  end

  describe "残金確認処理" do
    it "残金が表示されること" do
      vm = vendingMachine=VendingMachine.new
      vm.in(1000)
      vm.buy_a_drink("cola")
      expect(vm.current_total).to eq 880
    end
  end

  describe "お釣り確認処理" do
    it "お釣りが表示されること" do
      vm = vendingMachine=VendingMachine.new
      vm.in(1000)
      vm.buy_a_drink("cola")
      vm.return
      expect(vm.current_change).to eq 880
    end
  end

  describe "個別商品の情報確認処理" do
    it "個別の商品情報が表示されること(cola)" do
      vm = vendingMachine=VendingMachine.new
      expect(vm.product_price).to include :cola, 120, 5
    end
    it "個別の商品情報が表示されること(redbull)" do
      vm = vendingMachine=VendingMachine.new
      expect(vm.product_price(product_name: "redbull")).to include :redbull, 200, 1
    end
    it "個別の商品情報が表示されること(water)" do
      vm = vendingMachine=VendingMachine.new
      expect(vm.product_price(product_name: "water")).to include :water, 100, 1
    end
  end
end