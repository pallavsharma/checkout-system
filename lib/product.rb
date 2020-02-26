class Product

  def initialize(items)
    @items = items
  end

  def find_by_item(item)
    @items.include?(item)
  end

  def get_price(item)
    @items[item]
  end
end
