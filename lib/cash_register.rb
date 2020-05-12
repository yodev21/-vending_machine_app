class CashRegister
attr_reader :total, :sales, :change

 def initialize(total: 0, sales: 0, change: 0)
    @total = total
    @sales = sales
    @change = change
  end

  def add_total(money)
    @total += money
  end

  def refund
    @change = @total
    @total = 0

    return @change, @total
  end

  def purchase(price)
    @total -= price
  end

  def add_sales(price)
    @sales += price
  end
end