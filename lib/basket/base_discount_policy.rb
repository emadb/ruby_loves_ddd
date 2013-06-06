Dir["./lib/**/*.rb"].each {|file| require file }

module BasketManagement
  class BaseDiscountPolicy
    def self.inherited(subclass)
      DiscountFactory.add_new(subclass.name.split('::').last, subclass)
    end

    def self.apply (items = nil)
      1
    end
  end

  class Less10 < BaseDiscountPolicy
    def self.apply (items = nil)
      0.9
    end
  end

  class ThreeForTwo < BaseDiscountPolicy
    def self.apply (items)
      # TODO: implement the correct logic
      0.6667
    end
  end
end
