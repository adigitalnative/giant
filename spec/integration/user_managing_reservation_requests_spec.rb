require 'spec_helper'

describe "A visitor" do

end

describe "A signed in user with an item that has a pending reservation request" do
  before do
    @signed_in_user = Factory(:user, email: "signed_in@mail.com")
    @signed_in_user_item = Factory(:item, user_id: @signed_in_user.id)
    second_user = Factory(:user, email: "second_user@mail.com")
    @reservation = Factory(:reservation, item_id: @signed_in_user_item.id, user_id: second_user.id)
    visit root_path
    fill_in "Email", with: @signed_in_user.email
    fill_in "Password", with: "password"
    click_link_or_button("Sign in")
  end

  describe "on the warehouse show for the item" do
    before do
      visit warehouse_item_path(@signed_in_user_item.id)
    end

    it "displays the request" do
      within("#reservations") { page.should have_selector("#reservation_#{@reservation.id}") }
    end

    it "has a link to manage the request" do
      within("#reservation_#{@reservation.id}") { click_link_or_button "Manage" }
      current_path.should eq(edit_item_reservation_path(@reservation.item_id, @reservation.id))
    end
  end

  describe "on the hoard show for the item" do
    before do
      visit hoard_item_path(@signed_in_user_item.id)
    end

    it "displays requests" do
      within("#reservations") { page.should have_selector("#reservation_#{@reservation.id}") }
    end

    it "has a link to manage the request" do
      within("#reservation_#{@reservation.id}") { click_link_or_button "Manage" }
      current_path.should eq(edit_item_reservation_path(@reservation.item_id, @reservation.id))
    end
  end

  describe "approving the request" do
    before do
      Factory(:status, name: "Approved")
      visit edit_item_reservation_path(@signed_in_user_item.id, @reservation.id)
      select "Approved", from: "Status"
      click_link_or_button "Update Reservation"
    end

    it "displays an appropriate notice" do
      within("#notice") { page.should have_content("Reservation request approved")}
    end

    it "redirects to the correct page" do
      current_path.should eq(hoard_item_path(@signed_in_user_item.id))
    end

    it "displays the approval on the page" do
      within("#reservation_#{@reservation.id}") { page.should have_content("Approved") }
    end

    it "no longer displays a management link on the hoard show" do
      within("#reservation_#{@reservation.id}") { page.should_not have_link "Manage"}
    end

    it "no longer displays a management link on the warehouse show" do
      visit warehouse_item_path(@reservation.item_id)
      within("#reservation_#{@reservation.id}") { page.should_not have_link "Manage" }
    end
  end

  describe "denying the request" do
    before do
      Factory(:status, name: "Denied")
      visit edit_item_reservation_path(@signed_in_user_item.id, @reservation.id)
      select "Denied", from: "Status"
      click_link_or_button "Update Reservation"
    end

    it "displays an appropriate notice" do
      within("#notice") { page.should have_content("Reservation request denied")}
    end

    it "redirects to the correct page" do
      current_path.should eq(hoard_item_path(@signed_in_user_item.id))
    end

    it "displays the denial on the page" do
      within("#reservation_#{@reservation.id}") { page.should have_content("Denied") }
    end

    it "no longer displays a management link on the hoard show" do
      within("#reservation_#{@reservation.id}") { page.should_not have_link "Manage"}
    end

    it "no longer displays a management link on the warehouse show" do
      visit warehouse_item_path(@reservation.item_id)
      within("#reservation_#{@reservation.id}") { page.should_not have_link "Manage" }
    end
  end


  describe "A signed in user viewing another user's item" do
    before do
      @another_users_item = Factory(:item, user_id: Factory(:user).id)
    end

    describe "when the signed in user has a reservation pending" do
      before do
        @reservation = Factory(:reservation, user_id: @signed_in_user.id, item_id: @another_users_item.id)
        visit warehouse_item_path(@another_users_item.id)
      end

      it "displays the reservation" do
        within("#reservations") { page.should have_selector("#reservation_#{@reservation.id}") }
      end

      it "does not provide a link to manage the reservation" do
        within("#reservation_#{@reservation.id}") { page.should_not have_link "Manage" }
      end

      it "does not surface the status change option on the edit page" do
        visit edit_item_reservation_path(@another_users_item.id, @reservation.id)
        page.should_not have_selector(".reservation_status")
      end
    end

    describe "when the signed in user has a reservation approved" do
      before do
        approved_status = Factory(:status, name: "Approved")
        @reservation = Factory(:reservation, user_id: @signed_in_user.id, item_id: @another_users_item.id)
        @reservation.update_attributes(status_id: approved_status.id)
        visit warehouse_item_path(@another_users_item.id)
      end

      it "displays the approval" do
        within("#reservation_#{@reservation.id}") { page.should have_content("Approved") }
      end
    end

    describe "when the signed in user has a reservation denied" do
      before do
        approved_status = Factory(:status, name: "Denied")
        @reservation = Factory(:reservation, user_id: @signed_in_user.id, item_id: @another_users_item.id)
        @reservation.update_attributes(status_id: approved_status.id)
        visit warehouse_item_path(@another_users_item.id)
      end

      it "displays the denial" do
        within("#reservation_#{@reservation.id}") { page.should have_content("Denied") }
      end
    end
  end
end