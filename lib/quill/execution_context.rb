module Quill
  class ExecutionContext
    attr_accessor :output
    private :output=, :output

    def initialize language, output
      metaclass.send :include, language
      self.output = output
    end

    def execute_command command
      command.execute
    rescue Quill::Error => e
      output.puts e.message
    end

    private
    def metaclass
      class << self; self; end
    end
  end
end
