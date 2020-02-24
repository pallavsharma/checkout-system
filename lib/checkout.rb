require_relative 'product'

class Checkout
  def initialize(pricing_rules = nil)
    @pricing_rules = pricing_rules
    @order = Hash.new(0)
    @products = Product.new({FR1: 3.11, AP1: 5.00, CF1: 11.23})
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

  attr_reader :order, :pricing_rules, :products

  def order_cost
    (sum_without_discounts - discounts).round(2)
  end

  def discounts
    pricing_rules.reduce(0) do |discount, rule|
      discount += rule.apply(order, products)
    end
  end

  def sum_without_discounts
    order.reduce(0) do |sum, (item, num)|
      sum += products.get_price(item) * num
    end
  end

  def item_in_products?(item_code)
    products.find_by_item item_code
  end
end
