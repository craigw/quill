require 'spec_helper'

describe Quill::ExecutionContext do
  def execution_context options = {}
    options[:language] ||= Quill::Language
    options[:output] ||= StringIO.new
    Quill::ExecutionContext.new options[:language], options[:output]
  end

  describe "being initialised" do
    it "behaves like an instance of the language" do
      module TestLanguage; end
      execution_context(:language => TestLanguage).should be_kind_of TestLanguage
    end
  end

  it "provides a way to execute commands inside the context" do
    execution_context.should respond_to :execute_command
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
