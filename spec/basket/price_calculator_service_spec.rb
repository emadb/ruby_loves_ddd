require 'spec_helper'
require 'basket/price_calculator_service'
require 'basket/basket_item'
require 'basket/article'
# se non richiediamo questa classe, la classe Less10 e company non vengono
# censite e lo sconto non viene applicato, si deve probabilmente lanciare
# un'eccezione se si tenta di applicare un discuont e questo non e' censito,
# piuttosto che non applicarlo silenziosamente
require 'basket/base_discount_policy'

module BasketManagement
  describe PriceCalculatorService do
    before do
      @service = described_class.new
    end
    it 'should return the total price of all items' do
      items = []
      items << BasketItem.new(Article.new('foo', 10.0), 1)
      items << BasketItem.new(Article.new('bar', 5.0), 3)

      price = @service.calculate(items)

      expect(price).to eq(25.0)
    end

    it 'should consider the coupons' do
      @service.apply_coupon('Less10')
      items = []
      items << BasketItem.new(Article.new('foo', 10.0), 1)
      items << BasketItem.new(Article.new('bar', 5.0), 3)

      price = @service.calculate(items)

      expect(price).to eq(22.5)
    end
  end
end
