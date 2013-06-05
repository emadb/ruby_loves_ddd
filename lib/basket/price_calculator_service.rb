module BasketManagement
  class PriceCalculatorService
    def initialize
      @discount_factory = DiscountFactory
      @discount = 1
    end
    
    def calculate (items)
      total = items.reduce(0) do |sum, item|  
        sum = sum + item.total_price
      end
      
      # TODO: the discount_policy should receive the item list to manage various cases
      @discount = @discount_policy.apply unless @discount_policy.nil?
      total * @discount 
    end

    def apply_coupon (coupon)
      @discount_policy = @discount_factory.get_policy(coupon)
    end
  end
end