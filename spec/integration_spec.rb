require 'spec_helper'
require './lib/command_executor'

describe 'Basket and Warehouse scenarios' do
	include CommandExecutor	
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
	  
	  execute_command BasketManagement::AddToBasketCommand.new(2,1)
	end
end