require 'spec_helper'

describe ItemType do
  it "has a valid factory" do
    Factory(:item_type).should be_valid
  end

  it "is invalid without a name" do
    Factory.build(:item_type, name: nil).should_not be_valid
  end

  describe ".items" do
    it "returns an array" do
      Factory(:item_type).items.class.should eq(Array)
    end
  end
end
