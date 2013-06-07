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

	def subscribe_to event, method_name
		hash = get_hash event
    hash[:subscribers] << {instance: self,  method: method_name}
	end

	
  def get_hash event
  	@@subscribers ||= []
    elements = @@subscribers.select {|f| !f[:event].nil? and f[:event] = event } 
    if elements.size == 0
      hash = {event: event, subscribers: []}
	    @@subscribers << hash
      hash
    else
      elements[0]
    end
  end

end