
require File.join(File.dirname(__FILE__), '..', 'core_ext.rb')
require './lib/basket/basket_item'
require './lib/aggregate_root_helper'

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
      get_item(item).try(:increase_quantity) || @items << BasketItem.new(item)      
      raise_event :item_added, item
    end

    def remove_item (item)
      selected_item = get_item(item)
      selected_item.decrease_quantity
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
      @price_calculator_service.apply_coupon(code)
      raise_event :discount_applied, code
    end

    private
    def get_item (item)
      @items.select{|i| i.item == item}.try :first
      
    end
  end
end
