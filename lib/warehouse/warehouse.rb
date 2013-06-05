require './lib/aggregate_root_helper'

module WarehouseArea
  class Warehouse
    include AggregateRootHelper

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
        raise_event :article_locked, [article_id, basket_id]
      end
    end
    def unlock (article_id)
      article = @repository.get_by_code(article_id)
      if (article.nil?)
        raise 'article not available'
      else
        article.unlock
        #@repository.save article
        raise_event :article_unlocked, [article_id]
      end
    end
  end
end