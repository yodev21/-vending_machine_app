module Message
  
  private

  def self.insert_message(money)
    print "#{money}円投入されました!\n"
  end

  def self.current_total_message(total: 0)
    print "現在の合計金額は#{total}円です!\n"
  end

  def self.insert_error_message(money, total)
    print "そのお金は受け付けていません!\n"
    print "#{money}円は残金に反映されませんでした\n"
    print "#{money}円は払い戻しされました!\n"
    print "現在の合計金額#{total}円です!\n"
  end

  def self.current_change_message(change)
    print "お釣りは#{change}円です!\n"
  end

  def self.refund_message(change)
    print "#{change}円のお釣りです！\n"
  end

  def self.drink_name_conversion(drink_name: "cola")
    case drink_name
    when "cola"
      drink_name = "コーラ"
    when :cola
      drink_name = "コーラ"
    when "redbull"
      drink_name = "レッドブル"
    when :redbull
      drink_name = "レッドブル"
    when "water"
      drink_name = "水"
    when :water
      drink_name = "水"
    end
  end

  def self.replenishment_message(drink_name: "cola")
    drink_name = drink_name_conversion(drink_name: drink_name)
    print "#{drink_name}を補充をしました!\n"
  end

  def self.lineup_message
    print "現在のラインナップ\n"
  end

  def self.lineup_drink_message(drink_name: "cola", drink_price: 0, drink_number: 0)
    drink_name = drink_name_conversion(drink_name: drink_name)
    print "#{drink_name}, #{drink_price}円, #{drink_number}本\n"
  end

  def self.available_for_purchase_lineup_message
    print "購入可能なラインナップを表示\n"
  end

  def self.available_for_purchase_drink_message(drink_name: "cola")
    drink_name = drink_name_conversion(drink_name: drink_name)
    print "#{drink_name}が買えるか確認します\n"
  end

  def self.available_for_purchase_message(drink_name: "cola")
    drink_name = drink_name_conversion(drink_name: drink_name)
    print "在庫があり、金額が足りるので#{drink_name}を購入できます\n"
  end

  def self.inventory_shortage_message
    print "金額は足りますが、在庫がありません。\n"
  end

  def self.lack_of_money(drink_name: "cola")
    drink_name = drink_name_conversion(drink_name: drink_name)
    print "金額が足りないので#{drink_name}を購入できません!\n"
  end

  def self.buy_a_drink_message(drink_name: "cola")
    print "#{drink_name}を購入します！\n"
  end

  def self.purchased_a_drink_message(drink_name: "cola")
    drink_name = drink_name_conversion(drink_name: drink_name)
    print "在庫があり、金額が足りるので#{drink_name}を購入しました!\n"
  end

  def self.subtraction_process_message(drink_price: 0)
    print "合計金額から#{drink_price}円が引かれました!\n"
  end

  def self.add_sales_message(price: 0)
    print "売上金に#{price}円を追加しました!\n"
  end

  def self.current_stock_number(drink_name: "cola", drink_number: 0)
    drink_name = drink_name_conversion(drink_name: drink_name)
    print "現在の#{drink_name}の本数は#{drink_number}本です!\n"
  end

  def self.not_available_due_to_ack_of_stock_message
    print "金額は足りますが、在庫がありませんので購入できませんでした!\n"
  end

  def self.not_available_for_purchase
    print "購入可能な商品はありませんでした！\n"

  end

  def self.do_not_have_enough_money_to_buy(drink_name: "cola")
    print "金額が足りないので#{drink_name}を購入できませんでした!\n"
  end
end