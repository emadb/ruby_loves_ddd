module Handlers
  class AddToBasketHandler

    def initialize (repository = BasketManagement::BasketRepository.new)
      @repository = repository 
    end

    def execute(add_to_basket_command)
      # TODO: should be trasactional
      basket = @repository.get_basket(add_to_basket_command.basket_id)
      article = @repository.get_article(add_to_basket_command.article_id)
      basket.add_item (article) 
      basket.commit     
    end
  end
end

