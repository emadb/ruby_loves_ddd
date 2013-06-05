class AggregateRoot
  attr_reader :uncommited_events
  
  def apply_event (event, *args)
    if @uncommited_events.nil?
      @uncommited_events = []
    end

     @uncommited_events << {event: event, args: args}
  end

  def commit
    while event = @uncommited_events.shift
      # TODO persist the events
      # TODO notify subscribers using a message bus
    end
  end

  def self.subscribe event, handler 
    subscribers << {event: event, handler: handler, clazz: self}
  end

  
  def self.subscribers
    @@subscribers ||= []
  end
end