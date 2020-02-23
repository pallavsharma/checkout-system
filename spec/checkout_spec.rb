require_relative '../lib/checkout'
require_relative '../lib/discounts/bogo_discount'
require_relative '../lib/discounts/item_discount'

describe Checkout do
  let(:bogo_discount) { BogoDiscount.new(item_code: 'FR1') }
  let(:item_discount) { ItemDiscount.new(item_code: "AP1", min_items: 3, discount: 0.5) }
  let(:pricing_rules) { [bogo_discount, item_discount] }
  subject(:checkout) { described_class.new(pricing_rules) }

  describe '#scan' do
    it 'is expected to raise an error if given a code that is not in products' do
      expect{ checkout.scan('XYZ') }.to raise_error 'XYZ is not a valid item code'
    end
  end

  describe '#total' do
    it 'is expected to return the cost of the items calculated' do
      checkout.scan('FR1')
      checkout.scan('AP1')
      checkout.scan('FR1')
      checkout.scan('CF1')

      expect(checkout.total).to eq '$19.34'
    end

    it 'is expected to return the cost of the items calculated' do
      checkout.scan('FR1')
      checkout.scan('FR1')

      expect(checkout.total).to eq '$3.11'
    end

    it 'is expected to return the cost of the items calculated' do
      checkout.scan 'AP1'
      checkout.scan 'AP1'
      checkout.scan 'FR1'
      checkout.scan 'AP1'

      expect(checkout.total).to eq '$16.61'
    end
  end
end
