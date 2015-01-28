require 'spec_helper'

describe ItemTypeAssignment do
  it "has a valid factory" do
    Factory(:item_type_assignment).should be_valid
  end

  it "is invalid without an item_id" do
    Factory.build(:item_type_assignment, item_id: nil).should_not be_valid
  end

  it "is invalid without an item_type_id" do
    Factory.build(:item_type_assignment, item_type_id: nil).should_not be_valid
  end
end
