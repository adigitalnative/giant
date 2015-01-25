require 'spec_helper'

describe AccountType do
  it "has a valid factory" do
    Factory(:account_type).should be_valid
  end

  it "is invalid without a name" do
    Factory.build(:account_type, name: nil).should_not be_valid
  end
end
