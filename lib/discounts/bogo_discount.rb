class BogoDiscount
  def initialize(item_code:)
    @item_code = item_code.to_sym
  end

  def apply(order, products=nil)
    should_discount_be_applied?(order) ? apply_discount(order, products) : 0
  end

  private

  attr_reader :item_code

  def should_discount_be_applied?(order)
    order[item_code] >= 2
  end

  def apply_discount(order, products)
    (order[item_code] / 2).floor * products.get_price(item_code)
  end
end
