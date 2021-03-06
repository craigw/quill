module Quill
  class Application
    QUIT_COMMAND = "quit"

    attr_accessor :execution_context, :input, :output
    private :execution_context=, :input=, :output=

    def initialize options = {}
      self.input = options[:input] || STDIN
      self.output = options[:output] || STDOUT
      self.execution_context = ExecutionContext.new output
    end

    def load language
      const_names = language.split(/::/)
      expected_file = const_names.map(&:downcase).join('/')
      require expected_file
      klass = const_names.inject(Object) { |a,e| a.const_get e }
      execution_context.support klass
    end

    def run
      print_welcome
      loop do
        output.print prompt
        line = input.gets.to_s.strip
        if blank? line
          output.puts
          next
        end
        command = Command.build line, execution_context
        execution_context.execute_command command
        break if quit_command? line
      end
    end

    def prompt
      "> "
    end

    def print_welcome
      output.puts "Welcome to Quill #{Quill::VERSION}."
    end

    def blank? line
      line == ""
    end

    def quit_command? command
      command == Quill::Application::QUIT_COMMAND
    end
  end
end
