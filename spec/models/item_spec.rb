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

  describe ".belongs_to?" do
    before do
      @user = Factory(:user)
    end

    describe "when the item belongs to the user" do
      it "returns true" do
        Factory(:item, user_id: @user.id).belongs_to?(@user).should be_true
      end
    end

    describe "when the item belongs to a different user" do
      it "returns false" do
        other_user = Factory(:user, email: "other_user@mail.com")
        Factory(:item, user_id: other_user.id).belongs_to?(@user).should be_false
      end
    end

  end

  describe ".reservations" do
    it "returns an array" do
      Factory(:item).reservations.class.should eq(Array)
    end
  end
end
