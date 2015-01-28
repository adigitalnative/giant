require 'spec_helper'

describe Item do
  it "has a valid factory" do
    Factory(:item).should be_valid
  end
  it "is invalid without a name" do
    Factory.build(:item, name: nil).should_not be_valid
  end
  it "is invalid without a description" do
    Factory.build(:item, description: nil).should_not be_valid
  end

  it "is invalid without a user_id" do
    Factory.build(:item, user_id: nil).should_not be_valid
  end

  it "can have item_types" do
    Factory(:item).item_types.class.should eq(Array)
  end

  it "has a boolean for archive" do
    Factory(:item).archived?.should be_false
  end
end
