module Quill
  class Command
    DELIMETER = " "
    NoSuchCommand = Class.new StandardError

    def self.build input, execution_context
      name = name_from input
      arguments = arguments_from input
      raise NoSuchCommand, "No such command: #{name}" unless execution_context.respond_to? name
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
      execution_context.send name, *arguments
    end
  end
end
