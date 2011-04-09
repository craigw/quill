require 'quill'
require 'optparse'

app = Quill::Application.new

options = { :language => [] }
OptionParser.new do |o|
  o.on('--language LANGUAGE') { |language| options[:language] << language }
  o.parse!
end

languages = options[:language].flatten.compact.uniq
languages.map! { |l| l.strip }
languages.select { |l| l != "" }.each do |language|
  app.load language
end
app.run
