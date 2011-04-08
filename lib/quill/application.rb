module Quill
  class Application
    QUIT_COMMAND = "quit"

    attr_accessor :execution_context, :input, :output
    private :execution_context=, :input=, :output=

    def initialize options = {}
      self.input = options[:input] || STDIN
      self.output = options[:output] || STDOUT
      language = options[:language] || Quill::Language
      self.execution_context = ExecutionContext.new language, output
    end

    def run
      loop do
        line = input.gets.to_s.strip
        next if blank? line
        command = Command.build line, execution_context
        execution_context.execute_command command
        break if quit_command? line
      end
    end

    def blank? line
      line == ""
    end

    def quit_command? command
      command == Quill::Application::QUIT_COMMAND
    end
  end
end
