require 'spec_helper'

describe UserAccountType do
  it "has a working factory" do
    Factory(:user_account_type).should be_valid
  end

  it "is invalid without a user" do
    Factory.build(:user_account_type, user_id: nil).should_not be_valid
  end

  it "is invalid without a account_type" do

    Factory.build(:user_account_type, account_type_id: nil).should_not be_valid
  end
end
