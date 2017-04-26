module HomeHelper
  def selected_cities(city)
    if city.present?
      @city.name
    end
  end

  def discount_price(price)
    discount = price * 0.10
    (price - discount).to_i
  end
end
