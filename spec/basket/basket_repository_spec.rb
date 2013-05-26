require './lib/basket/basket_repository'
require './lib/basket/basket'

describe BasketRepository do

  it 'should create a new basket in the collection' do
    repository = BasketRepository.new
    basket = Basket.new
    basket.description = 'test'
    basket.add_item(Article.new('one', 5))
    basket.add_item(Article.new('two', 10))
    repository.save basket
  end
end
