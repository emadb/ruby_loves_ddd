require './lib/basket/basket_item'

class Basket
  def initialize (price_calculator_service = nil)
    @items = []
    @price_calculator_service = price_calculator_service
    @discount = 1
  end

  def items
    @items
  end

  def add_item (item)
    selected_item = get_item(item)
    if selected_item
      selected_item.increase_quantity
    else
      new_item = BasketItem.new(item)
      @items << new_item
    end
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
    selected_items = @items.select{|i| i.item == item}
    selected_items[0] if selected_items.size == 1
  end
end

