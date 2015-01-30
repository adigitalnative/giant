require 'spec_helper'

describe Status do
  it "has a valid factory" do
    Factory(:status).should be_valid
  end

  it "is invalid without a name" do
    Factory.build(:status, name: nil).should_not be_valid
  end
end
