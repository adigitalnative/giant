require 'spec_helper'

describe "A visitor" do
  it "cannot reserve an item" do
    visit new_item_reservation_path(Factory(:item))
    page.should have_content("need to sign in")
  end
end

describe "A signed in user" do
  before do
    @signed_in_user = Factory(:user, email: "signed_in@mail.com")
    visit warehouse_path
    fill_in "Email", with: @signed_in_user.email
    fill_in "Password", with: "password"
    click_link_or_button("Sign in")
  end

  describe "when other users have items" do
    before do
      other_user = Factory(:user, email: "other_user@mail.com")
      @other_user_item = Factory(:item, user_id: other_user.id)
    end

    describe "placing a reservation request" do
      describe "with good inputs" do
        it "succeeds with required input" do
          visit warehouse_item_path(@other_user_item.id)
          within("#item") { click_link_or_button "Reserve Item"}
          select Date.today.year.to_s, from: "start_date_i1"
          select "January", from: "start_date_i2"
          select Date.today.day.to_s, from: "start_date_i3"
          select Date.today.year.to_s, from: "end_date_i1"
          select "January", from: "end_date_i2"
          select Date.today.day.to_s, from: "end_date_i3"
          click_link_or_button "Submit Request"
          page.should have_content("Request submitted")
        end

        it "sees the request information on the warehouse item page"
      end
    end

    describe "editing a reservation request" do
      it "succeeds if the request is still pending"
      it "fails if the request is approved or denied"
    end
  end

  describe "viewing their own warehouse items" do

  end
end