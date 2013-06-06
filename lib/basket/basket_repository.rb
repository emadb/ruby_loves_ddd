module BasketManagement
  class BasketRepository
    def save (basket)
      # save the aggregate to the database
    end

    def get (basket_id)
      Basket.new
    end

    def get_basket (basket_id)
      Basket.new
    end

    def get_article(article_id)
      Article.new(1,10)
    end
  end
end