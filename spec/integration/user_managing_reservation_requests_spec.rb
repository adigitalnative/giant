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
   

  # describe "on the hoard show for the item" do
  #   before do
  #     visit user_item_path(@signed_in_user.id, @signed_in_user_item.id)
  #   end

  #   it "displays requests" do
  #     within("#reservations") { page.should have_selector("#reservation_#{@reservation.id}") }
  #   end

  #   it "has a link to manage the request" do
  #     within("#reservation_#{@reservation.id}") { click_link_or_button "Manage" }
  #     current_path.should eq(edit_item_reservation_path(@reservation.item_id, @reservation.id))
  #   end
  # end

  # describe "approving the request" do
  #   before do
  #     # visit edit_item_reservation_path(@signed_in_user_item.id, @reservation.id)
  #   end

  #   it "displays an appropriate notice"
  #   it "redirects to the correct page"
  #   it "displays the approval on the page"
  # end

  describe "denying the request" do
    before do
      visit warehouse_item_path(@signed_in_user_item.id)
    end

    it "displays an appropriate notice"
    it "redirects to the correct page"
    it "displays the denial on the page"
  end
end

describe "A signed in user viewing another user's item" do
  describe "when the signed in user has a reservation pending" do
    it "displays the reservation"
    it "does not provide a link to manage the reservation"
    it "does not surface the status change option on the edit page"
    it "does not allow a non-owner to change the status (Controller)"
  end

  describe "when the signed in user has no reservations but another user does" do
    it "does not display the reservation"
  end
end