module BasketManagement
  class BasketRepository
    def save (basket)
      # save the aggregate to the database
    end

    def get (basket_id)
      #get the aggregate from database
    end

    def get_basket (basket_id)     
      # get some events from the store
      events = [
        {:aggregate_id => 1, :name => :item_added, :args => 2  },
        {:aggregate_id => 1, :name => :item_added, :args => 3  },
        {:aggregate_id => 1, :name => :item_removed, :args => 2  },
        {:aggregate_id => 1, :name => :item_added, :args => 4  },
      ]
      basket = Basket.new
      basket.apply_events events
      basket
    end

    def get_article(article_id)
    end
  end
end