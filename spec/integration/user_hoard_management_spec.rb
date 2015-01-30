require 'spec_helper'

describe "A visitor to the site" do
  it "requires login to see the hoard" do
    visit hoard_path
    page.should have_content "need to sign in"
  end

  it "requires login to see a hoard item" do
    item = Factory(:item)
    visit hoard_item_path(item.id)
    page.should have_content "need to sign in"
  end
end

describe "A signed in user" do
  before do
    @signed_in_user = Factory(:user, email: "test_user@foo.com")
    visit root_path
    fill_in "Email", with: @signed_in_user.email
    fill_in "Password", with: "password"
    click_link_or_button("Sign in")
  end

  describe "creating an item" do
    it "succeeds with only required values" do
      item_type = Factory(:item_type, name: "A Test Item Type") 
      visit hoard_path
      click_link_or_button "Add item"
      fill_in "Name", with: "A Name"
      fill_in "Description", with: "The super cool description"
      click_link_or_button "Create Item"

      page.should have_content("Item added to your hoard")
    end
  end

  describe "who has items" do
    before do
      @item_one = Factory(:item, user_id: @signed_in_user.id)
      @item_two = Factory(:item, user_id: @signed_in_user.id)
      @item_three = Factory(:item, user_id: @signed_in_user.id)
      visit hoard_path
    end

    it "can see a list of their items" do
      within("#items") { page.should have_selector("#item_#{@item_one.id}")}
      within("#items") { page.should have_selector("#item_#{@item_two.id}")}
      within("#items") { page.should have_selector("#item_#{@item_three.id}")}
    end

    it "can view a detail page for an item" do
      within("#item_#{@item_one.id}") { click_link_or_button @item_one.name }
      current_path.should eq(hoard_item_path(@item_one.id))
    end

    it "can edit their items" do
      within("#item_#{ @item_one.id }") { click_link_or_button "Edit" }
      fill_in "Name", with: "New Name"
      click_link_or_button "Update"
      within("#item_#{ @item_one.id }") { page.should have_content("New Name") }
    end

    it "can delete their items" do
      within("#item_#{ @item_one.id }") { click_link_or_button "Delete" }
      within("#items") { page.should_not have_selector("#item_#{ @item_one.id }") }
    end

    it "can archive their items" do
      within("#item_#{ @item_one.id }") { click_link_or_button "Edit" }
      check "Archive"
      click_link_or_button "Update"
      within("#item_#{ @item_one.id }") { page.should have_content("Archived") }
    end
  end

  describe "viewing another user's hoard_items" do
    before do
      other_user = Factory(:user, email: "other_user@mail.com")
      item = Factory(:item, user_id: other_user.id)
      visit hoard_item_path(item.id)
    end

    it "redirects to the user's own hoard" do
      current_path.should eq(hoard_path)
    end

    it "shows an appropriate error message" do
      within("#alert") { page.should have_content("not permitted to view someone else's hoard")}
    end
  end
end