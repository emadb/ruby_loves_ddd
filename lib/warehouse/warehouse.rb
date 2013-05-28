module WarehouseArea
  class Warehouse

    def initialize(repository)
      @repository = repository
    end

    def lock (article_id, basket_id)
      article = @repository.get_by_code(article_id)
      if (article.nil?)
        raise 'article not available'
      else
        article.lock_for(basket_id)
        #@repository.save article
      end
    end
    def unlock (article_id)
      article = @repository.get_by_code(article_id)
      if (article.nil?)
        raise 'article not available'
      else
        article.unlock
        #@repository.save article
      end
    end
  end
end