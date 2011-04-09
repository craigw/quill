module Quill
  class Command
    DELIMETER = " "
    NoSuchCommand = Class.new Quill::Error

    def self.build input, execution_context
      name = name_from input
      arguments = arguments_from input
      Command.new execution_context, name, *arguments
    end

    def self.name_from input
      input.split(DELIMETER, 2)[0]
    end
    class << self; private :name_from; end

    def self.arguments_from input
      input.split(DELIMETER)[1..-1]
    end
    class << self; private :arguments_from; end

    attr_accessor :name, :arguments, :execution_context
    private :name=, :arguments=, :execution_context=

    def initialize execution_context, name, *arguments
      self.execution_context = execution_context
      self.name = name
      self.arguments = arguments
    end

    def execute
      raise no_such_command name unless command_exists? name
      execution_context.send name, *arguments
    end

    def no_such_command name
      NoSuchCommand.new "No such command: #{name.inspect}"
    end
    private :no_such_command

    def command_exists? name
      execution_context.respond_to? name
    end
  end
end
