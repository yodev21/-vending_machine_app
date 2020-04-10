require './lib/drink'
class VendingMachine

  AVAILABLE_MONEY = [10, 50, 100, 500, 1000].freeze

  # 初期化
  def initialize
    @drink_table = {}
    @stock = 0
    @total = 0
    @sales = 0
    5.times do |n|
      stock Drink.cola
    end
  end

  # 商品の追加
  def stock(drink)

    # すでに存在している場合、在庫に追加する
    if @drink_table.has_key? drink.name
      @count = @drink_table[drink.name][:drinks]
      @count += 1
      @drink_table[drink.name][:drinks] = @count 
    # 新商品だった場合
    else
      @drink_table[drink.name] = {price: drink.price,
                                  drinks: []}
      @count = @drink_table[drink.name][:drinks]
      @count = 0
      @count += 1
      @drink_table[drink.name][:drinks] = @count 
    end
    @drink_table[drink.name]
  end

  # 商品情報出力
  def stock_info
    @drink_table
  end

  # お金投入
  def insert(money)
    if AVAILABLE_MONEY.include?(money)
      @total += money 
      nil
    else
      money
    end
  end

  # 払い戻し
  def refund
    total = @total.dup
    @total = 0
    total    
  end

  # 商品購入
  def purchase(drink_name)
    @count = @drink_table[drink_name][:drinks]
    @drink_price = @drink_table[drink_name][:price]
    if @count != 0 &&  @total >= @drink_price.to_i
      @count -= 1
      @drink_table[drink_name][:drinks] = @count
      @sales += @drink_table[drink_name][:price]
      @total -= @drink_price
      return @total
    end
  end
end

