require './lib/command_executor'

include CommandExecutor

describe CommandExecutor do
  before do
    @is_called = false
  end
  it 'execut command should execute the command' do
    command = FakeCommands::FakeTestCommand.new('test')
    execute_command command
    expect(command.is_called).to be_true
  end
  
end


  module FakeCommands
    class FakeTestCommand
      attr_accessor :is_called
      def initialize(name)
      end
    end
  end

  module Handlers
    class FakeTestHandler
      def execute (command)
        command.is_called = true
      end
    end
  end
