class AggregateRoot
  attr_reader :uncommited_events
  
  def apply_event (event, *args)
    if @uncommited_events.nil?
      @uncommited_events = []
    end

     @uncommited_events << {event: event, args: args}
  end

  def commit
    @uncommited_events.each do |e|
      # persist the events
    end
  end
end