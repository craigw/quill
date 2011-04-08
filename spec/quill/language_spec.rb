require 'spec_helper'

class FakeContext
  attr_accessor :output
  def initialize
    self.output = StringIO.new
  end
  include Quill::Language
end

describe Quill::Language do
  describe "when included in a containing class" do
    let(:context) { FakeContext.new }

    it "supports a 'quit' command" do
      context.should respond_to :quit
    end

    describe "the quit command" do
      it "shows a good-bye message" do
        context.quit
        output = context.output
        output.rewind
        output.read.should =~ /Bye!/
      end
    end

    it "supports a 'help' command" do
      context.should respond_to :help
    end

    describe "the help command" do
      it "shows the Quill version" do
        context.help
        output = context.output
        output.rewind
        output.read.should =~ /Quill #{Quill::VERSION}/
      end

      it "lists the commands that the language supports" do
        context.help
        output = context.output
        output.rewind
        commands = (Quill::Language.methods - Quill::Language.class.methods)
        commands.sort! { |a, b| a.to_s <=> b.to_s }
        output.read.should =~ /Commands: #{commands.join(', ')}/
      end
    end
  end
end
