class MessageBus
  @callbacks = []
  
  def self.subscribe message_type, &callback
    hash = get_hash message_type
    hash[message_type] << callback
  end

  def self.publish message_type
    hash = get_hash message_type
    hash[message_type].each{ |c| c.call}
  end

  private 
  def self.get_hash message_type
    elements = @callbacks.select {|f| !f[message_type].nil? } 
    if elements.size == 0
      hash = {message_type => []}
      @callbacks << hash
      hash
    else
      elements[0]
    end
  end

end