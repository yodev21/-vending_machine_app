require 'spec_helper'
describe Drink do
  describe "アクセサメソッド" do
    context "読み込み処理を行った場合" do
      it "コーラの情報が表示されること" do
        cola = Drink.cola
        expect(cola.name).to eq(:cola)
        expect(cola.price).to eq(120)
      end

      it "レッドブルの情報がされること" do
        redbull = Drink.redbull
        expect(redbull.name).to eq(:redbull)
        expect(redbull.price).to eq(200)
      end

      it "水の情報が表示されること" do
        water = Drink.water
        expect(water.name).to eq(:water)
        expect(water.price).to eq(100)
      end
    end
  end
end