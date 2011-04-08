require 'spec_helper'

describe Quill::Command do
  describe "being built" do
    it "takes a command string and an execution context to run in" do
      context = stub_everything("Execution Context")
      command = Quill::Command.build "QUIT\n", context
      command.should be_kind_of Quill::Command
      command.name.should == "QUIT"
      command.arguments.should be_empty
      command.execution_context.should == context
    end
  end

  describe "executing the command" do
    it "executes the command in the execution context" do
      context = stub_everything("Execution Context")
      command = Quill::Command.build "THINGY A B\n", context
      context.expects(:THINGY).once.with("A", "B")
      command.execute
    end
  end
end
