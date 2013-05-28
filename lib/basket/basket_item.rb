module BasketManagement
  class BasketItem
    attr_reader :item, :quantity
    
    def initialize (item, quantity = 1)
      @item = item
      @quantity = quantity
    end

    def increase_quantity
      @quantity = @quantity + 1
    end

    def decrease_quantity
      @quantity = @quantity - 1
    end

    def item_price
      @item.price
    end

    def item_id
      @item.id
    end

    def total_price
      item_price * quantity
    end
  end
end