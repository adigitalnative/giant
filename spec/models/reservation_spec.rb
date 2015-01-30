require 'spec_helper'

describe Reservation do
  it "has a valid factory" do
    Factory(:reservation).should be_valid
  end

  it "is invalid without a user_id" do
    Factory.build(:reservation, user_id: nil).should_not be_valid
  end

  it "is invalid without a item_id" do
    Factory.build(:reservation, item_id: nil).should_not be_valid
  end

  it "is invalid without a start_date" do
    Factory.build(:reservation, start_date: nil).should_not be_valid
  end

  it "is invalid without a end_date" do
    Factory.build(:reservation, end_date: nil).should_not be_valid
  end

  describe "when there is a 'pending' status in the system" do
    it "sets a new reservation's status to 'pending' by default" do
      pending_status = Factory(:status, name: "Pending")
      Factory(:reservation).status_id.should eq(pending_status.id)
    end
  end

  describe "when it is the first reservation in the system" do
    it "creates a pending status and sets the reservations' status to pending by default" do
      Factory(:reservation).status.name.should eq("Pending")
    end

    it "creates an 'Accepted' status" do
      Factory(:reservation)
      Status.all.map { |status| status.name }.include?("Approved").should be_true
    end

    it "creates a 'Denied' status" do
      Factory(:reservation)
      Status.all.map { |status| status.name }.include?("Denied").should be_true
    end
  end

end
