module CommandExecutor
  def execute_command (command)
    handler = find_handler(command)
    handler.execute command
  end

  def find_handler(command)
    class_name = command.class.name.split('::').last.sub(/Command/, '') + 'Handler'
    klass = Handlers.const_get(class_name)       
    klass.new
  end
end

module Commands
  class AddToBasketCommand
    attr_reader :basket_id, :article_id
    def initialize(basket_id, article_id)
      @basket_id = basket_id
      @article_id = article_id
    end
  end
end

module Handlers
  class AddToBasketHandler

    def initialize
      @repository = BasketManagement::BasketRepository.new
    end

    def execute(add_to_basket_command)
      # TODO: should be trasactional
      basket = @repository.get_basket(add_to_basket_command.basket_id)
      article = @repository.get_article(add_to_basket_command.article_id)
      basket.add_item (article)
    end
  end
end

