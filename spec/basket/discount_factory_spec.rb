require 'spec_helper'
require 'basket/discount_factory'

module BasketManagement
  describe DiscountFactory do
    before do

    end

    it 'should receive new policy' do
      Dummy = Class.new {}

      DiscountFactory.add_new('Dummy', Dummy)
      policy = DiscountFactory.get_policy('Dummy')

      expect(policy).to eq(Dummy)
    end

    it 'should be able to manage multiple policies' do
      Dummy1 = Class.new {}
      Dummy2 = Class.new {}

      DiscountFactory.add_new('Dummy1', Dummy1)
      DiscountFactory.add_new('Dummy2', Dummy2)
      policy1 = DiscountFactory.get_policy('Dummy1')
      policy2 = DiscountFactory.get_policy('Dummy2')

      expect(policy1).to eq(Dummy1)
      expect(policy2).to eq(Dummy2)
    end


  end
end
