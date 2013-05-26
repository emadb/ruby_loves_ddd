require 'mongo'

class BasketRepository
  include Mongo

  def initialize
    db = MongoClient.new('localhost', 27017).db('eshop')
    @baskets_collection = db["baskets"]
  end

  def save (basket)
    if basket.id.nil?
      hash = {}
      basket.instance_variables.each {|var| hash[var.to_s.delete("@")] = basket.instance_variable_get(var) }

      @baskets_collection.insert hash
    else
      @baskets_collection.update({"_id" => id}, basket)
    end
  end

  def get (basket_id)
    @baskets_collection.find_one("_id" => id)
  end
end