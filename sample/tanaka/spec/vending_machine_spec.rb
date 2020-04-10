require 'spec_helper'
describe VendingMachine do
  describe '商品追加処理'do
    context '初期化された場合' do
      it 'colaの本数が5本あること' do
        vm = VendingMachine.new
        info = vm.stock_info.dup
        expect(info['cola'][:drinks]).to eq 5
      end
    end
    context 'redbullを追加した場合' do
      it 'redbullの本数が表示されること' do
        vm = VendingMachine.new
        vm.stock(Drink.redbull)
        info = vm.stock_info.dup
        expect(info['redbull'][:drinks]).to eq 1
      end
      it 'redbullの情報が表示されること' do
        vm = VendingMachine.new
        vm.stock(Drink.redbull)
        info = vm.stock_info.dup
        expect(vm.stock_info).to include "redbull"
        expect(info['redbull'][:price]).to eq 200
      end
    end
    context 'waterを追加した場合' do
      it 'waterの本数が表示されること' do
        vm = VendingMachine.new
        vm.stock(Drink.water)
        info = vm.stock_info.dup
        expect(info['water'][:drinks]).to eq 1
      end
      it 'waterの情報が表示されること' do
        vm = VendingMachine.new
        vm.stock(Drink.water)
        info = vm.stock_info.dup
        expect(vm.stock_info).to include "water"
        expect(info['water'][:price]).to eq 100
      end
    end
    context '複数追加した場合' do
      it '追加した分本数が表示されること' do
        vm = VendingMachine.new
        vm.stock(Drink.redbull)
        vm.stock(Drink.redbull)
        info = vm.stock_info.dup
        expect(info['redbull'][:drinks]).to eq 2
      end
    end
  end

  describe 'お金投入処理' do
    context '想定したお金を投入した場合' do
      it '戻り値がnilであること' do
        vm = VendingMachine.new
        expect(vm.insert(10)).to be nil
        expect(vm.insert(50)).to be nil
        expect(vm.insert(100)).to be nil
        expect(vm.insert(500)).to be nil
        expect(vm.insert(1000)).to be nil
      end
      it '投入金額が加算されていること' do
        vm = VendingMachine.new
        vm.insert(10)
        vm.insert(50)
        vm.insert(100)
        vm.insert(500)
        vm.insert(1000)
        expect(vm.refund).to eq 1660
      end
    end
  end

  describe '購入処理' do
    context '投入金額が不足している状態でcolaを購入した場合' do
      it '購入処理が行われないこと' do
        vm = VendingMachine.new
        expect(vm.purchase('cola')).to be nil
      end
    end
    context '在庫が不足している状態でcolaを購入した場合' do
      it '購入処理が行われないこと' do
        vm = VendingMachine.new
        vm.insert(1000)
        5.times do |n|
          vm.purchase('cola')
        end
        expect(vm.purchase('cola')).to be nil
      end
    end
    context '購入できる金額が投入された状態でcolaを購入した場合' do
      it '釣り銭が表示されること' do
        vm = VendingMachine.new
        vm.insert(1000)
        expect(vm.purchase('cola')).to eq 880
      end
    end
    context '払い戻し処理を行った場合' do
      it '釣り銭が表示されること' do
        vm = VendingMachine.new
        vm.insert(1000)
        expect(vm.refund).to eq 1000
      end
    end
  end
end