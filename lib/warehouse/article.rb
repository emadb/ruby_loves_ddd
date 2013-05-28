module WarehouseArea
  class Article
    attr_reader :locked, :basket_id
    def initialize(id: nil, code: '', row: 0, shelf: 0)
      
    end

    def lock_for(basket_id)
      @locked = true
      @basket_id = basket_id
    end

    def unlock
      @locked = false
      @basket_id = nil
    end

  end
end