# First of all you will need to import checkout and item files from lib,
# This will import all the classes required to run the system
require_relative 'lib/checkout'

# You will also need to require any discounts you plan to use in your system,
# These are stored in lib/discounts
require_relative 'lib/discounts/item_discount'
require_relative 'lib/discounts/bogo_discount'

# We want to apply a BOGO discount for Fruit tea.
bogo_discount = BogoDiscount.new(item_code: "FR1")

# We want to apply a 0.5$ discount per item when you order 3 or more "AP1" items
items_discount = ItemDiscount.new(item_code: "AP1", min_items: 3, discount: 0.5)

# You can then store these in an array to be injected into the system,
# These should be ordered in the order you want them to be applied
pricing_rules = [items_discount, bogo_discount]

# The checkout has two methods,
# #scan => this takes the key code of the item as a string and adds it to your basket
# #total => this returns the cost of the current basket as a string in pounds
# To initialize the system initialize the Checkout with the pricing_rules and your products
# For example here's a basket which takes advantage of both rules we built

checkout = Checkout.new(pricing_rules)
checkout.scan 'FR1'
checkout.scan 'FR1'
checkout.scan 'AP1'
checkout.scan 'CF1'
price = checkout.total
price # => "$19.34"

checkout = Checkout.new(pricing_rules)
checkout.scan 'FR1'
checkout.scan 'FR1'
price = checkout.total
price # => "$3.11"

checkout = Checkout.new(pricing_rules)
checkout.scan 'AP1'
checkout.scan 'AP1'
checkout.scan 'FR1'
checkout.scan 'AP1'
price = checkout.total
price # => "$16.61"
