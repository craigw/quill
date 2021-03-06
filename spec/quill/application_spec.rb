require 'spec_helper'

class FakeDSL
  def method_missing *args; end
end

describe Quill::Application do
  describe "being instanciated" do
    it "uses Quill::Language as the default language for the execution context" do
      app = Quill::Application.new
      app.execution_context.should have_support_for Quill::Language
    end

    it "takes an input to read commands from" do
      input = stub_everything('Input')
      app = Quill::Application.new :input => input
      app.input.should == input
    end

    it "uses STDIN as the default input" do
      app = Quill::Application.new
      app.input.should be STDIN
    end

    it "takes an output to read commands from" do
      output = stub_everything('Output')
      app = Quill::Application.new :output => output
      app.output.should == output
    end

    it "uses STDOUT as the default output" do
      app = Quill::Application.new
      app.output.should be STDOUT
    end
  end

  describe "loading a language" do
    it "loads the language into the ExecutionContext" do
      language = "Spec::Fixtures::Language"
      app = Quill::Application.new
      app.load language
      app.execution_context.should have_support_for Spec::Fixtures::Language
    end
  end

  describe "being run" do
    it "stops when #{Quill::Application::QUIT_COMMAND} is input" do
      input = StringIO.new
      app = Quill::Application.new :input => input, :output => StringIO.new
      lambda {
        Timeout.timeout 1 do
          app.run
        end
      }.should raise_error Timeout::Error

      app = Quill::Application.new :input => input, :output => StringIO.new
      input << Quill::Application::QUIT_COMMAND
      input.rewind
      lambda {
        Timeout.timeout 0.1 do
          app.run
        end
      }.should_not raise_error Timeout::Error
    end

    it "executes commands on the execution context based on the input" do
      input = StringIO.new "#{Quill::Application::QUIT_COMMAND}\n"
      app = Quill::Application.new :input => input, :output => StringIO.new, :language => FakeDSL
      command = stub_everything "Command"
      expectation = Quill::Command.expects :build
      call = expectation.with Quill::Application::QUIT_COMMAND, app.execution_context
      call.returns command
      command.expects :execute
      app.run
    end
  end
end
