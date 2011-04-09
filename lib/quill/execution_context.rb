module Quill
  class ExecutionContext
    attr_accessor :output, :languages
    private :output=, :output, :languages=, :languages

    def initialize output
      self.output = output
      self.languages = []
      self.support Quill::Language
    end

    def support language
      implementation = redirect_output_from(language).new output
      languages << implementation
    end

    def supports_command? command
      languages.any? { |i| i.respond_to? command }
    end

    def has_support_for? language
      languages.any? { |implementation| implementation.kind_of? language }
    end

    def language_for command_name
      languages.detect { |i| i.respond_to? command_name }
    end

    def run command_name, *args
      i = language_for command_name
      i.send command_name, *args
    end

    def execute_command command
      command.execute
    rescue Quill::Error => e
      output.puts e.message
    end

    def redirect_output_from language
      Class.new language do
        attr_accessor :output
        private :output=, :output
        def initialize output
          self.output = output
        end

        def puts *args
          output.puts *args
        end
      end
    end
    private :redirect_output_from
  end
end
