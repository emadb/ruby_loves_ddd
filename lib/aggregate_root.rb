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
      
      puts "COUNT #{AggregateRoot.subscribers.size}"
      AggregateRoot.subscribers.each do |e| 
        puts "SUB CLASS #{e[:clazz]}"
        puts "SELF CLASS #{self.class}"
        if event = e[:event] and e[:clazz] == self.class
          puts "Handler #{e[:handler]}"
          # TODO: Find a way to call the handler on the instance
          send(e[:handler])
        end
      end

    end
  end

  def self.subscribe event, handler
    puts "SUBCRIBED: #{event.class}"
    subscribers << {event: event, handler: handler, clazz: self}
  end

  
  def self.subscribers
    @@subscribers ||= []
  end
end