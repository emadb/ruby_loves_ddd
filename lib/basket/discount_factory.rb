module BasketManagement
  class DiscountFactory
    @policies = {}
    def self.get_policy (code)
      @policies[code]
    end

    def self.add_new (code, klass)
      @policies[code] = klass
    end
  end
end