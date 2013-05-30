module CommandExecutor
  def execute_command (command)
    handler = find_handler(command)
    handler.execute command
  end

  def find_handler(command)
    class_name = command.class.name.split('::').last.sub(/Command/, '') + 'Handler'
    klass = Handlers.const_get(class_name)       
    klass.new
  end
end