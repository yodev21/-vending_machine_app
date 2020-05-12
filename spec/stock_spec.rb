require "spec_helper"
describe Stock do
  describe "補充機能" do
    context "補充処理を行われた場合" do
      it "コーラの在庫が加算されること" do
        cola = Stock.new(product_name: :cola, number: 5)
        expect(cola.replenishment).to eq(6)
      end

      it "レッドブルの在庫が加算されること" do
        redbull = Stock.new(product_name: :redbull, number: 1)
        expect(redbull.replenishment).to eq(2)
      end

      it "水の在庫が加算されること" do
        water = Stock.new(product_name: :water, number: 1)
        expect(water.replenishment).to eq(2)
      end

      it "指定された個数分在庫が加算されること" do
        redbull = Stock.new(product_name: :redbull, number: 1)
        expect(redbull.replenishment(number: 4)).to eq(5)
      end
    end
  end

  describe "発送機能" do
    context "発送処理が行われた場合" do
      it "コーラの在庫が減算されること" do
        cola = Stock.new(product_name: :cola, number: 5)
        expect(cola.shipment).to eq(4)
      end

      it "レッドブルの在庫が加算されること" do
        redbull = Stock.new(product_name: :redbull, number: 1)
        expect(redbull.shipment).to eq(0)
      end

      it "水の在庫が加算されること" do
        water = Stock.new(product_name: :water, number: 1)
        expect(water.shipment).to eq(0)
      end

      it "指定された個数分在庫が減算されること" do
        redbull = Stock.new(product_name: :redbull, number: 5)
        expect(redbull.shipment(number: 3)).to eq(2)
      end
    end
  end
end