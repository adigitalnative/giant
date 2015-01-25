require 'spec_helper'

describe User do
  it "has a valid factory" do
    Factory(:user).should be_valid
  end

  it "is invalid without a first_name" do
    Factory.build(:user, first_name: nil).should_not be_valid
  end

  it "is invalid without a last_name" do
    Factory.build(:user, last_name: nil).should_not be_valid
  end

end
