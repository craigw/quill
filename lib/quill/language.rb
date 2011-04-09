module Quill
  class Language
    def quit
      puts "Bye!"
    end

    def help
      puts "Quill #{Quill::VERSION}"
      puts "Commands: help, quit"
    end
  end
end
