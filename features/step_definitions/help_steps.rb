When /^I ask for help$/ do
  enter_command :help
end

Then /^I should see the help screen$/ do
  output.rewind
  text = output.read
  text.should =~ /Quill #{Quill::VERSION}/
end
