require 'spec_helper'
require 'basket/basket'
require 'basket/basket_repository'
require 'basket/handlers/add_to_basket_handler'
require 'basket/commands/add_to_basket_command'

include Handlers

describe AddToBasketHandler  do
  it 'should create a new basket item in the collection' do
    fake_repo = double('basket_repository')
    basket = BasketManagement::Basket.new
    article = BasketManagement::Article.new(1, 'test')
    fake_repo.stub(:get_basket => basket)
    fake_repo.stub(:get_article => article)

    handler = AddToBasketHandler.new(fake_repo)
    
    handler.execute BasketManagement::AddToBasketCommand.new(2,1)
    expect(basket.item_count).to eq(1)
  end
end