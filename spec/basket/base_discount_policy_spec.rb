require './lib/basket/base_discount_policy'
require './lib/basket/discount_factory'

describe BaseDiscountPolicy do
  before do
    class DummyDiscount < BaseDiscountPolicy
    end
  end

  it 'add the policy whenever I inherith from base' do
    klass = DiscountFactory.get_policy('DummyDiscount')
    expect(klass).to eq(DummyDiscount)
  end
end


describe Less10 do
  it 'should return 10% of discount (0.9)' do
    expect(Less10.apply).to eq(0.9)
  end
end

describe ThreeForTwo do
  it 'shuold return 10% of discount (0.9)' do
    items = []
    items << BasketItem.new(Article.new(1, 10))
    items[0].increase_quantity
    items[0].increase_quantity

    expect(ThreeForTwo.apply(items)).to eq(0.6667)
  end
end



