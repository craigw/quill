module Quill
  module Language
    def quit
      output.puts "Bye!"
    end

    def help
      output.puts "Quill #{Quill::VERSION}"
      output.puts "Commands: help, quit"
    end
  end
end
