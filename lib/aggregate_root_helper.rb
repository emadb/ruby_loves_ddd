module AggregateRootHelper
  @@subscribers = Hash.new{|hash,key| hash[key]=[]}

  def id= id
    @id = id
  end

  def id
    @id
  end

  def uncommited_events
    @uncommited_events || []
  end

  def self.included(klass)
    klass.extend AggregateRootHelper
  end
  
  def subscribe_to(event, method)
    @@subscribers[event] << {klass: self, method: method}
  end

  def raise_event(event, *args)
     uncommited_events << {event: event, args: args}
  end

  # TODO: error checking
  def commit
    while event = uncommited_events.shift
      send_event event
    end
  end

  def send_event send_event
    @@subscribers[event].each do |subscriber| 
      ObjectSpace.each_object subscriber[:klass] do |instance|
        instance.send subscriber[:method], args
      end
    end
  end
end