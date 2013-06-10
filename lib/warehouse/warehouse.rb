module WarehouseArea
  class Warehouse
    include AggregateRootHelper
    subscribe_to :item_added, :on_item_added

    def initialize(repository)
      @repository = repository
    end

    def lock (article_id, basket_id)
      article = @repository.get_by_code(article_id)
      if (article.nil?)
        raise_error'article not available'
      else
        article.lock_for(basket_id)
        #@repository.save article
      end
    end

    def unlock (article_id)
      article = @repository.get_by_code(article_id)
      if (article.nil?)
        raise_error 'article not available'
      else
        article.unlock
        #@repository.save article
      end
    end

    def on_item_added(item_id)
      # Do something with the item. Probably lock it.
    end


  end
end