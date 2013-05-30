
Dir["./lib/**/*.rb"].each {|file| require file }

describe BasketManagement::BasketRepository do
  it 'should rebuild the basket from the event collection' do
    repository = BasketManagement::BasketRepository.new
    basket = repository.get_basket 1

    expect(basket.items.size).to eq(2)
  end
end
