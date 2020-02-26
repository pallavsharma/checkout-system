require_relative '../../lib/discounts/item_discount'

describe ItemDiscount do
  subject(:item_discount) { described_class.new(item_code: "AP1", min_items: 3, discount: 0.5) }

  describe '#apply' do
    it 'is expected to apply the discount on orders which contain more than the 3 of items' do
      expect(item_discount.apply({order: {AP1: 4}})).to eq 2
    end

    it 'is expected to apply no discount on orders which contain less than the 3 of items' do
      expect(item_discount.apply({order: {AP1: 2}})).to eq 0
    end
  end
end
