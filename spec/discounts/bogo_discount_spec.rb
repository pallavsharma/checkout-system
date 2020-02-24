require_relative '../../lib/product'
require_relative '../../lib/discounts/bogo_discount'

describe BogoDiscount do
  let(:products) { Product.new({FR1: 3.11, AP1: 5.00, CF1: 11.23}) }
  subject(:bogo_discount) { described_class.new(item_code: "FR1") }

  describe '#apply' do
    it 'is expected to apply the bogo discount on orders' do
      expect(bogo_discount.apply({FR1: 2}, products)).to eq 3.11
    end

    it 'is expected to apply no bogo discount on orders which contain less than the number of items' do
      expect(bogo_discount.apply({FR1: 1}, products)).to eq 0
    end
  end
end
