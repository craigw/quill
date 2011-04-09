require 'spec_helper'

describe Quill::ExecutionContext do
  def execution_context options = {}
    options[:output] ||= StringIO.new
    Quill::ExecutionContext.new options[:output]
  end

  describe "being initialised" do
    it "supports the Quill language out of the box" do
      ctx = execution_context
      ctx.should have_support_for Quill::Language
    end
  end

  it "provides a way to execute commands inside the context" do
    execution_context.should respond_to :execute_command
  end

  describe "providing support for a language" do
    it "redirects the output of the language to the execution context output" do
      class LanguageWithPuts
        def action
          puts "foo"
        end
      end

      output = StringIO.new
      ctx = execution_context :output => output
      ctx.support LanguageWithPuts
      # FIXME: Yuck, don't use private API
      i = ctx.send(:languages).detect { |i| i.kind_of? LanguageWithPuts }
      i.action
      output.rewind
      output.read.should == "foo\n"
    end
  end

  describe "executing a command" do
    it "executes the command" do
      command = stub_everything "Command"
      command.expects(:execute).once
      execution_context.execute_command command
    end

    describe "when something goes wrong" do
      it "puts the error message on the execution context's output" do
        buffer = StringIO.new
        context = execution_context :output => buffer
        command = stub_everything "Command"
        command.expects(:execute).raises Quill::Error, "No Jam For You"
        context.execute_command command
        buffer.rewind
        buffer.read.should =~ /No Jam For You/
      end
    end
  end
end
