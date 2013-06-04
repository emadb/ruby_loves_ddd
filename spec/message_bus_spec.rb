require './lib/message_bus'

describe MessageBus do
  
  it 'should be able to accept subscribers' do
      MessageBus.subscribe :message_1 do
        
      end
  end

	it 'should be able to send a message to its subscribers' do
	  i_was_here = false
	  i_was_not_here = true
	  MessageBus.subscribe :message_1 do
	    i_was_here = true
	  end

	  MessageBus.subscribe :message_2 do
	    i_was_not_here = false
	  end

	  MessageBus.publish :message_1
	  
	  i_was_here.should be_true
	  i_was_not_here.should be_true

  end
end
