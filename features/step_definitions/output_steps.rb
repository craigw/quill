Then /^I should see "([^"]*)"$/ do |message|
  output.rewind
  output.read.should =~ /#{message}/
end