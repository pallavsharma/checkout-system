require_relative 'base_discount'

class BogoDiscount < BaseDiscount
  def initialize(item_code:)
    @item_code = item_code.to_sym
  end

  private

  attr_reader :item_code

  def should_discount_be_applied?(order)
    order[item_code] >= 2
  end

  def apply_discount(args={})
    (args[:order][item_code] / 2).floor * args[:products].get_price(item_code)
  end
end
