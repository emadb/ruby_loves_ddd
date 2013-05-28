require './lib/basket/price_calculator_service'

describe PriceCalculatorService do
  before do
    @service = PriceCalculatorService.new
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