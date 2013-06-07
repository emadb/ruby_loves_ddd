module AggregateRootHelper
  @@subscribers = Hash.new{|hash,key| hash[key]=[]}

  def id= id
    @id = id
  end

  def id
    @id
  end

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

class Bar
  include AggregateRootHelper
  subscribe_to :my_event, :my_method

  def my_method
    puts 'my_method is called'
  end
end

class EventRaiser 
  include AggregateRootHelper
  def fire
    raise_event :my_event
  end
end