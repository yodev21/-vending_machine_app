module Message
  private

  def self.insert_message(money)
    print "--------------------------------------------------------------------------------------------------------------------\n"
    print "#{money}円投入されました!\n"
  end

  def self.current_total_message(total: 0)
    print "--------------------------------------------------------------------------------------------------------------------\n"
    print "現在の合計金額は#{total}円です!\n"
  end

  def self.insert_error_message(money, total)
    print "--------------------------------------------------------------------------------------------------------------------\n"
    print "そのお金は受け付けていません!\n"
    print "#{money}円は残金に反映されませんでした\n"
    print "#{money}円は払い戻しされました!\n"
    print "現在の合計金額#{total}円です!\n"
  end

  def self.current_change_message(change)
    print "--------------------------------------------------------------------------------------------------------------------\n"
    print "お釣りは#{change}円です!\n"
  end

  def self.refund_message(change)
    print "--------------------------------------------------------------------------------------------------------------------\n"
    print "#{change}円のお釣りです！\n"
  end

  def self.product_name_conversion(product_name: :cola)
    case product_name
    when :cola
      product_name = "コーラ"
    when :redbull
      product_name = "レッドブル"
    when :water
      product_name = "水"
    else
      product_name
    end
  end

  def self.replenishment_message(product_name: :cola)
    product_name = product_name_conversion(product_name: product_name)

    print "--------------------------------------------------------------------------------------------------------------------\n"
    print "#{product_name}を補充をしました!\n"
  end

  def self.lineup_message
    print "--------------------------------------------------------------------------------------------------------------------\n"
    print "現在のラインナップ\n"
  end

  def self.lineup_information_message(product_list: args={})
    procucts = []

    product_list.each do |product|
      product_name = product_name_conversion(product_name: product[0])
      print "--------------------------------------------------------------------------------------------------------------------\n"
      print "#{product_name}, #{product[1]}円, #{product[2]}本\n"
    end
  end

  def self.available_for_purchase_lineup_message
    print "--------------------------------------------------------------------------------------------------------------------\n"
    print "購入可能なラインナップを表示\n"
  end

  def self.purchase_confirmation_message(product_name: :cola)
    product_name = product_name_conversion(product_name: product_name)

    print "--------------------------------------------------------------------------------------------------------------------\n"
    print "#{product_name}が買えるか確認します\n"
  end

  def self.available_for_purchase_message(product_name: :cola)
    product_name = product_name_conversion(product_name: product_name)

    print "--------------------------------------------------------------------------------------------------------------------\n"
    print "在庫があり、金額が足りるので#{product_name}を購入できます\n"
  end

  def self.inventory_shortage_message
    print "--------------------------------------------------------------------------------------------------------------------\n"
    print "金額は足りますが、在庫がありません。\n"
  end

  def self.lack_of_money(product_name: :cola)
    product_name = product_name_conversion(product_name: product_name)

    print "--------------------------------------------------------------------------------------------------------------------\n"
    print "金額が足りないので#{product_name}を購入できません!\n"
  end

  def self.purchase_message(product_name: :cola)
    product_name = product_name_conversion(product_name: product_name)

    print "--------------------------------------------------------------------------------------------------------------------\n"
    print "#{product_name}を購入します！\n"
  end

  def self.purchased_message(product_name: :cola)
    product_name = product_name_conversion(product_name: product_name)

    print "--------------------------------------------------------------------------------------------------------------------\n"
    print "在庫があり、金額が足りるので#{product_name}を購入しました!\n"
  end

  def self.subtraction_process_message(product_price: 0)
    print "--------------------------------------------------------------------------------------------------------------------\n"
    print "合計金額から#{product_price}円が引かれました!\n"
  end

  def self.add_sales_message(product_price: 0)
    print "--------------------------------------------------------------------------------------------------------------------\n"
    print "売上金に#{product_price}円を追加しました!\n"
  end

  def self.current_stock_number(product_name: :cola, number_of_items: 0)
    product_name = product_name_conversion(product_name: product_name)

    print "--------------------------------------------------------------------------------------------------------------------\n"
    print "現在の#{product_name}の本数は#{number_of_items}本です!\n"
  end

  def self.not_available_due_to_ack_of_stock_message
    print "--------------------------------------------------------------------------------------------------------------------\n"
    p "金額は足りますが、在庫がありませんので購入できませんでした!"
  end

  def self.not_available_for_purchase
    print "--------------------------------------------------------------------------------------------------------------------\n"
    print "購入可能な商品はありませんでした！\n"

  end

  def self.do_not_have_enough_money_to_purchase(product_name: :cola)
    product_name = product_name_conversion(product_name: product_name)

    print "--------------------------------------------------------------------------------------------------------------------\n"
    p "金額が足りないので#{product_name}を購入できませんでした!"
  end
end