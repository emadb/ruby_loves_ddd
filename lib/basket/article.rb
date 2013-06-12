module BasketManagement
  class Article
    attr_reader :id, :price
    def initialize (id, price)
      @id, @price = id, price
    end
  end
end