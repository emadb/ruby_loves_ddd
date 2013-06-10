require 'spec_helper'

describe "I'm supposed to be a controller" do
  include CommandExecutor

  it 'when an action is called I fire a command' do
    
    execute_command AddToBasketCommand.new(1,2)

  end
end