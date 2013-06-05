
require File.join(File.dirname(__FILE__), '..', 'core_ext.rb')
require './lib/basket/basket_item'

module BasketManagement
  class Basket
    attr_reader :items

    def initialize (price_calculator_service = nil) # PriceCalculatorService.new
      @items = []
      @price_calculator_service = price_calculator_service
      @discount = 1
    end

    def add_item (item)

      get_item(item).try(:increase_quantity) || @items << BasketItem.new(item) 
      # selected_item = get_item(item)
      # if selected_item
      #   selected_item.increase_quantity
      # else
      #   new_item = BasketItem.new(item)
      #   @items << new_item
      # end
    end

    def remove_item (item)
      selected_item = get_item(item)
      selected_item.decrease_quantity
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
      @price_calculator_service.apply_coupon(code)
    end

    private
    def get_item (item)
      @items.select{|i| i.item == item}.try :first
      
    end
  end
end
