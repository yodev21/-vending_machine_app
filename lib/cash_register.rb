class CashRegister
attr_accessor :total, :sales, :change
 def initialize(total: 0, sales: 0, change: 0)
    @total = total
    @sales = sales
    @change = change
  end
end