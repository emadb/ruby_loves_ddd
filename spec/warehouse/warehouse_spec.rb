require 'spec_helper'

describe WarehouseArea::Warehouse do
  before do
    @repository = double('warehouse_repository')
    @warehouse = WarehouseArea::Warehouse.new (@repository)
  end

  it 'reserve an item that is about to be taken' do
    article1 = WarehouseArea::Article.new(id: 123, code: 'article1', row: 5, shelf: 10)
    @repository.stub(:get_by_code => article1)
    
    @warehouse.lock 'article1', 'basket_id'

    expect(article1.locked).to be_true
    expect(article1.basket_id).to eq('basket_id')
    # TODO: Verify that save is called
    #@repository.should_receive(:save).with(article1)
  end

  it 'the item is not present in the warehouse' do
    @repository.stub(:get_by_code => nil)
    expect{@warehouse.lock('article1', 'basket_id')}.to raise_error
  end

  it 'should unlock an item that is not needed anymore' do
    article1 = WarehouseArea::Article.new(id: 123, code: 'article1', row: 5, shelf: 10)
    @repository.stub(:get_by_code => article1)
    @warehouse.lock 'article1', 'basket_id'

    @warehouse.unlock 'article1'

    expect(article1.locked).to be_false
    expect(article1.basket_id).to eq(nil)
    # TODO: Verify that save is called
    #@repository.should_receive(:save).with(article1)
  end
end
