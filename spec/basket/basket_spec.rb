Dir["./lib/**/*.rb"].each {|file| require file }

module BasketManagement

  describe BasketManagement::Basket do
    before do
      @basket = Basket.new (PriceCalculatorService.new)
      @item_one = Article.new('one', 5.00)
      @item_two = Article.new('two', 10.00)
    end

    it 'should have an id' do
      @basket.id = 'new-basket'
      expect(@basket.id).to eq('new-basket')
    end 

    it 'should be possible to add a new item and count should raise' do
      @basket.add_item(@item_one)

      expect(@basket.item_count).to eq(1)
    end

    it 'does not change size if I add the same item twice' do
      @basket.add_item(@item_one)
      @basket.add_item(@item_one)

      expect(@basket.item_count).to eq(1)
    end

    it 'should increase quantity if I add the same item twice' do
      @basket.add_item(@item_one)
      @basket.add_item(@item_one)

      expect(@basket.items[0].quantity).to eq(2)
    end


    it 'should decrease quantity if I remove an item that is in the basket' do
      @basket.add_item(@item_one)
      @basket.add_item(@item_one)
      @basket.remove_item(@item_one)

      expect(@basket.items[0].quantity).to eq(1)
    end

    it 'should decrease quantity if I remove an item that is in the basket' do
      @basket.add_item(@item_one)
      @basket.add_item(@item_one)
      @basket.remove_item(@item_one)

      expect(@basket.items[0].quantity).to eq(1)
    end

    it 'should empty the basket' do
      @basket.add_item(@item_one)
      @basket.add_item(@item_two)
      @basket.empty

      expect(@basket.item_count).to eq(0)
    end

    it 'with one item should return the total items price' do
      @basket.add_item(@item_one)

      expect(@basket.total_price).to eq(5.00)
    end

    it 'with two items should return the total items price' do
      @basket.add_item(@item_one)
      @basket.add_item(@item_two)

      expect(@basket.total_price).to eq(15.00)
    end

    it 'with three items should return the total items price' do
      @basket.add_item(@item_one)
      @basket.add_item(@item_one)
      @basket.add_item(@item_two)

      expect(@basket.total_price).to eq(20.00)
    end

    it 'apply coupon to get a discount of 10%' do
      @basket.add_item(@item_one)
      @basket.add_item(@item_one)
      @basket.add_item(@item_two)

      @basket.apply_discount('Less10')

      expect(@basket.total_price).to eq(18.00)
    end

    context 'cqrs and ev' do
      it 'add_item should add event to the list' do
        @basket.add_item(@item_one)
        @basket.add_item(@item_two)
        expect(@basket.uncommited_events.size).to eq(2)
      end

      it 'remove_item should add event to the list' do
        @basket.add_item(@item_one)
        @basket.remove_item(@item_one)
        
        expect(@basket.uncommited_events.size).to eq(2)
      end

      it 'apply_coupon should add event to the list' do
        @basket.apply_discount('Less10')
        
        expect(@basket.uncommited_events.size).to eq(1)
      end
    end
  end
end
