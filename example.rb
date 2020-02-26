require_relative 'lib/checkout'
require_relative 'lib/discounts/item_discount'
require_relative 'lib/discounts/bogo_discount'

bogo_discount = BogoDiscount.new(item_code: "FR1")
items_discount = ItemDiscount.new(item_code: "AP1", min_items: 3, discount: 0.5)

pricing_rules = [items_discount, bogo_discount]

checkout = Checkout.new(pricing_rules)
checkout.scan 'FR1'
checkout.scan 'FR1'
checkout.scan 'AP1'
checkout.scan 'CF1'
price = checkout.total
puts price
