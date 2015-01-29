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
        before do
          visit warehouse_item_path(@other_user_item.id)
          within("#item") { click_link_or_button "Reserve Item"}
          select Date.today.year.to_s, from: "reservation_start_date_1i"
          select "January", from: "reservation_start_date_2i"
          select Date.today.day.to_s, from: "reservation_start_date_3i"
          select Date.today.year.to_s, from: "reservation_end_date_1i"
          select "January", from: "reservation_end_date_2i"
          select Date.today.day.to_s, from: "reservation_end_date_3i"
          click_link_or_button "Submit Request"
        end

        it "succeeds with required input" do
          page.should have_content("Reservation request submitted")
        end

        it "sets the reservation status to pending" do
          within("#reservations") { page.should have_content("Pending") }
        end
      end
    end

    describe "editing a reservation request" do
      before do
        @reservation = Factory(:reservation, item_id: @other_user_item.id)
      end

      it "succeeds if the request is still pending" do
        visit edit_item_reservation_path(@reservation.item_id, @reservation.id)
        select "March", from: "reservation_start_date_2i"
        click_link_or_button "Submit Request"
        within("#notice") { page.should have_content("Reservation request updated") }
      end

      describe "when the request is approved" do
        before do
          approved_status = Factory(:status, name: "Approved")
          @reservation.update_attributes(status_id: approved_status.id)
          visit edit_item_reservation_path(@reservation.item_id, @reservation.id)
        end

        it "sets an appropriate alert message" do
          within("#alert") { page.should have_content("cannot edit approved requests") }
        end

        it "redirects to the item show" do
          current_path.should eq(warehouse_item_path(@reservation.item_id))
        end
      end

      describe "when the request is denied" do
        before do
          denied_status = Factory(:status, name: "Denied")
          @reservation.update_attributes(status_id: denied_status.id)
          visit edit_item_reservation_path(@reservation.item_id, @reservation.id)
        end

        it "sets an appropriate alert message" do
          within("#alert") { page.should have_content("cannot edit denied requests") }
        end

        it "redirects to the item show" do
          current_path.should eq(warehouse_item_path(@reservation.item_id))
        end
      end
    end
  end

  describe "viewing their own warehouse items" do

  end
end