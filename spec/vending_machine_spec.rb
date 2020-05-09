require 'spec_helper'
describe VendingMachine do
  describe '初期表示メッセージ' do
    example "初期表示メッセージが出力されること" do
      expect(Manual.first_message).to eq("------------------------------------")
    end
  end

  describe '初期化処理' do
    example "未定" do
      expect(VendingMachine.new)
    end
  end

  # describe "お金投入処理" do
  #   context "お金を投入した場合" do
  #     it "想定した金額であればnilを返すこと" do
  #       vm = vendingMachine=VendingMachine.new
  #       expect(vm.in(500)).to be nil
  #     end
  #     it "Warn 想定外の金額であれば投入した金額を変えること" do
  #       vm = vendingMachine=VendingMachine.new
  #       expect(vm.in(5)).to be 5
  #     end
  #   end
  # end

  # describe "払い戻し処理" do
  #   context "払い戻し処理が行われた場合" do
  #     it "現在の投入金額が表示されること" do
  #       vm = vendingMachine=VendingMachine.new
  #       vm.in(500)
  #       vm.in(500)
  #       expect(vm.return).to be 1000
  #     end
  #   end
  # end

  # describe "初期補充処理" do
  #   context "初期補充処理が行われた場合" do
  #     it "colaの情報が表示されること" do
  #       vm = vendingMachine=VendingMachine.new
  #     end
  #   end
  # end
end