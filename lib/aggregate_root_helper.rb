module AggregateRootHelper
	def raise_event event, *args
    hash = get_hash event
    hash[:subscribers].each do |s|
      s[:instance].send(s[:method])
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