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

  it "can have items" do
    user = Factory.build(:user)
    user.items.class.should eq(Array)
  end

  describe ".full_name" do
    before do
      @test_user = Factory(:user, first_name: "Jane", last_name: "Doe", email: "janedoe@mail.com", phone: "392-392-3992")
    end

    it "returns the correct string" do
      @test_user.full_name.should eq("Jane Doe")
    end
  end

  describe ".account_types" do
    before do
      @test_user = Factory(:user, email: "account_user@mail.com")
      @account_type_one = Factory(:account_type, name: "Account Type One")
      @account_type_two = Factory(:account_type, name: "Account Type Two")
      @test_user.account_types << @account_type_one
      @test_user.account_types << @account_type_two
    end

    it "returns the account types" do
      @test_user.account_types.include?(@account_type_one).should be_true
      @test_user.account_types.include?(@account_type_two).should be_true
    end
  end

  describe ".account_types_list" do
    before do
      @test_user = Factory(:user)
    end

    it "returns a string" do
      @test_user.account_types_list.class.should eq(String)
    end
  end

  describe ".roles" do
    it "returns account types as an array of strings" do
      test_user = Factory(:user)
      account_type = Factory(:account_type, name: "Foo Account Type")
      test_user.account_types << account_type

      test_user.roles.include?(account_type.name).should be_true
    end
  end

  describe ".reservations" do
    it "returns an array" do
      Factory(:user).reservations.class.should eq(Array)
    end
  end
end
