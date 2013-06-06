module AggregateRootHelper
  @@subscribers = Hash.new{|hash,key| hash[key]=[]}

  def self.included(klass)
    klass.extend AggregateRootHelper
  end
  
  def subscribe_to(event, method)
    @@subscribers[event] << {klass: self, method: method}
  end

  def raise_event(event, *args)
    @@subscribers[event].each do |subscriber| 
      ObjectSpace.each_object subscriber[:klass] do |instance|
        instance.send subscriber[:method], args
      end
    end
  end
end
