require './lib/basket/discount_factory'

class BaseDiscountPolicy
  def self.inherited(subclass)
    DiscountFactory.add_new(subclass.name, subclass)
  end

  def self.apply (items = nil)
    1
  end
end

# TODO: Test this class
class Less10 < BaseDiscountPolicy
  def self.apply (items = nil)
    0.9
  end
end

# TODO: Test this class
class ThreeForTwo < BaseDiscountPolicy
  def self.apply (items)
  end
end