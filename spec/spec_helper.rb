require 'bundler'
Bundler.require :default, :test

require 'quill'

Spec::Runner.configure do |config|
  config.mock_with :mocha
end
