class BaseDiscountPolicy
  def self.inherited(subclass)
    DiscountFactory.add_new(subclass.name, subclass)
  end

  def apply
    1
  end
end

# class Less10 < BaseDiscountPolicy
# end