require './lib/basket/base_discount_policy'
require './lib/basket/discount_factory'

describe BaseDiscountPolicy do
  before do
    
  end

  it 'add the policy whenever I inherith from base' do
    class Dummy < BaseDiscountPolicy
    end

    klass = DiscountFactory.get_policy('Dummy')
    expect(klass).to eq(Dummy)
  end


end




