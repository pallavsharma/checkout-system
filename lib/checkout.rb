class Checkout
  PRODUCTS = {FR1: 3.11, AP1: 5.00, CF1: 11.23}

  def initialize(pricing_rules = nil)
    @pricing_rules = pricing_rules
    @order = Hash.new(0)
  end

  def scan(item_code)
    item_code = item_code.to_sym
    fail "#{item_code} is not a valid item code" unless item_in_products?(item_code)
    @order[item_code] += 1
  end

  def total
    '$%.2f' % order_cost
  end

  private

  attr_reader :order, :pricing_rules

  def order_cost
    apply_discounts(sum_without_discounts(order), order).round(2)
  end

  def apply_discounts(cost_before_discounts, order)
    pricing_rules.reduce(cost_before_discounts) do |current_total, rule|
      current_total - rule.apply(order)
    end
  end

  def sum_without_discounts(order)
    order.reduce(0) do |sum, (item, price)|
      sum += PRODUCTS[item] * price
    end
  end

  def item_in_products?(item_code)
    PRODUCTS.keys.include?(item_code)
  end
end
