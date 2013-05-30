# TODO: move to basket context

module BasketManagement
  class AddToBasketCommand
    attr_reader :basket_id, :article_id
    
    def initialize(basket_id, article_id)
      @basket_id = basket_id
      @article_id = article_id
    end
  end
end