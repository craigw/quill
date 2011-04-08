require 'spec_helper'

describe Quill::Error do
  it "is a kind of Standard Error" do
    Quill::Error.new.should be_kind_of StandardError
  end
end
