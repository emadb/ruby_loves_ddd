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




