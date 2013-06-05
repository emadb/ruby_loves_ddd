Dir["./lib/*.rb"].each {|file| require file }
Dir["./lib/basket/*.rb"].each {|file| require file }

describe 'Various interestig scenario' do

	class StubbedEntity
		include AggregateRootHelper
		attr_reader :is_called

		def initialize
			subscribe_to :item_added, :on_item_added
			@is_called = false
		end

		def on_item_added
			@is_called = true
		end
	end


  it 'should be able to send and receive domain events' do
		basket = BasketManagement::Basket.new    
		stub = StubbedEntity.new

		basket.add_item 'fake'

		expect(stub.is_called).to eq(true)

  end


end
