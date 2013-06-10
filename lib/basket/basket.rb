Dir["./lib/**/*.rb"].each {|file| require file }


module BasketManagement
  class Basket
    include AggregateRootHelper

    attr_reader :items

    def initialize (price_calculator_service = PriceCalculatorService.new)
      @items = []
      @price_calculator_service = price_calculator_service
      @discount = 1
    end

    def add_item (item)
      raise_event :item_added, item
    end

    def remove_item (item)
      raise_event :item_removed, item
    end

    def item_count
      @items.size
    end

    def empty
      @items.clear
    end

    def total_price
      @price_calculator_service.calculate (items)
    end

    def apply_discount (code)
      raise_event :apply_discount, code
    end

    def on_item_added item
      get_item(item).try(:increase_quantity) || @items << BasketItem.new(item)      
    end

    def on_item_removed item
      selected_item = get_item(item)
      selected_item.decrease_quantity
      if selected_item.quantity == 0
        items.delete selected_item
      end
    end

    def on_apply_discount code
      @price_calculator_service.apply_coupon(code)
    end

    private
    def get_item (item)
      @items.select{|i| i.item == item}.try :first
    end
  end
end
