require 'spec_helper'

describe BasketManagement::BaseDiscountPolicy do
  before do
    class DummyDiscount < subject.class
    end
  end

  it 'add the policy whenever I inherith from base' do
    klass = BasketManagement::DiscountFactory.get_policy('DummyDiscount')
    expect(klass).to eq(DummyDiscount)
  end
end


describe BasketManagement::Less10 do
  it 'should return 10% of discount (0.9)' do
    expect(subject.class.send(:apply)).to eq(0.9)
  end
end

describe BasketManagement::ThreeForTwo do
  it 'shuold return 10% of discount (0.9)' do
    items = []
    article = BasketManagement::Article.new(1, 10)
    items << BasketManagement::BasketItem.new(article)
    items[0].increase_quantity
    items[0].increase_quantity

    expect(subject.class.send(:apply, items)).to eq(0.6667)
  end
end

# describe Less15For3 do
#   it 'if the items count is greater than 3 items' do
#   end  
# end

# describe FreeShipping do
#   it 'if the total price is greater than 100 shipping is free of charge' do
#   end  
# end



