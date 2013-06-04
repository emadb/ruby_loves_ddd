require 'spec_helper'

describe 'Basket and Warehouse scenarios' do
	def create_handler
		fake_repo = double('basket_repository')
    basket = BasketManagement::Basket.new
    article = BasketManagement::Article.new(1, 'test')
    fake_repo.stub(:get_basket => basket)
    fake_repo.stub(:get_article => article)

    AddToBasketHandler.new(fake_repo)
	end

	def create_warehouse
		repository = double('warehouse_repository')
    WarehouseArea::Warehouse.new (@repository)
	end

	it 'when an item is added to the basket the warehouse should receive a message' do
		handler = create_handler
		warehouse = create_warehouse

	  handler.execute BasketManagement::AddToBasketCommand.new(2,1)


	end
end
