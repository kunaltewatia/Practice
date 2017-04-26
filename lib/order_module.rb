# metheds of Order controller
module OrderModule
  def calc_unit(plan, unit)
    if unit == 1
      price, discount, text = calc_discount_one(plan, unit, true)
    elsif unit == 2
      price, discount, text =  calc_discount_two(plan, unit, true)
    else
      price, discount, text =  calc_discount(plan, unit, true)
    end
    return [price.to_i, discount.to_i, text]
  end

  private

  def calc_discount_one(plan, unit, stop=true)
    base_price = plan.price * unit
    discount = base_price * 0.10
    price, discount = calc_price_discount(base_price, discount)
    nprice, ndiscount, ntext = calc_discount_two(plan, unit + 1, false)  if stop
    #text = "Buy #{unit + 1} dozens to avail discount worth Rs #{ndiscount.to_i}/-"
    text = "Buy #{unit + 1} dozen and Save Rs #{ndiscount.to_i}/-"
    return [price, discount, text]
  end

  def calc_discount_two(plan, unit, stop=true)
    base_price = plan.price * unit
    discount = base_price * 0.10
    price, discount = calc_price_discount(base_price, discount)
    nprice, ndiscount, ntext = calc_discount(plan, unit + 1, false)  if stop
    #text = "Buy #{unit + 1} dozens to avail discount worth Rs #{ndiscount.to_i}/-"
    text = "Buy #{unit + 1} dozen and Save Rs #{ndiscount.to_i}/-"
    return [price, discount, text]
  end

  def calc_discount(plan, unit, stop=true)
    base_price = plan.price * unit
    discount = base_price * 0.10
    price, discount = calc_price_discount(base_price, discount)
    nprice, ndiscount, ntext = calc_discount(plan, unit + 1, false)  if stop
    #text = "Buy #{unit + 1} dozens to avail discount worth Rs #{ndiscount.to_i}/-"
    text = "Buy #{unit + 1} dozen and Save Rs #{ndiscount.to_i}/-"
    return [price, discount, text]
  end

  def calc_price_discount(base_price, discount)
    price = base_price - discount
    final_price = price
    discount = discount
    return [final_price, discount]
  end
end
