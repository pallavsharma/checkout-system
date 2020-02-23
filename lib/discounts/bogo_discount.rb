require 'pry'
class BogoDiscount
  def initialize(item_code:)
    @item_code = item_code.to_sym
  end

  def apply(order)
    should_discount_be_applied?(order) ? apply_discount(order) : 0
  end

  private

  attr_reader :item_code

  def should_discount_be_applied?(order)
    order[item_code] >= 2
  end

  def apply_discount(order)
    (order[item_code] / 2).floor * Checkout::PRODUCTS[item_code]
  end
end
