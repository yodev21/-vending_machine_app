require 'spec_helper'
describe CashRegister do
  describe "アクセサメソッド" do
    context "読み込み処理を行った場合" do
      it "キャッシュレジストリーの情報が表示されること" do
        cash_register = CashRegister.new(total: 100, sales: 200, change: 300)
        expect(cash_register.total).to eq(100)
        expect(cash_register.sales).to eq(200)
        expect(cash_register.change).to eq(300)
      end
    end
  end

  describe "合計金額加算機能" do
    context "加算処理を行った場合" do
      it "合計金額が加算されること" do
        cash_register = CashRegister.new(total: 0, sales: 0, change: 0)
        expect(cash_register.add_total(100)).to eq(100)
      end
    end
  end

  describe "釣り銭機能" do
    context "払い戻し処理を行った場合" do
      it "お釣りが表示されること" do
        cash_register = CashRegister.new(total: 0, sales: 0, change: 0)
        cash_register.add_total(100)
        expect(cash_register.refund).to include 100
        expect(cash_register.refund).to include 0
      end
    end
  end

  describe "購入機能" do
    context "購入処理を行った場合" do
      it "合計金額が減算されること" do
        cash_register = CashRegister.new(total: 0, sales: 0, change: 0)
        cash_register.add_total(500)
        expect(cash_register.purchase(120)).to eq(380)
      end
    end
  end

  describe "売り上げ加算機能" do
    context "加算処理を行った場合" do
      it "売り上げが加算されること" do
        cash_register = CashRegister.new(total: 0, sales: 0, change: 0)
        expect(cash_register.add_sales(120)).to eq(120)
      end
    end
  end
end