Given /^a new Quill session$/ do
  start_session
end

When /^I quit the Quill session$/ do
  enter_command :quit
end

Then /^Quill should stop running$/ do
  terminated.should be_true
end
